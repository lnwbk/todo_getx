import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_getx/view/home_view.dart';
import 'package:todo_getx/view/login_view.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    user.bindStream(firebaseAuth.authStateChanges());
  }

  Future<void> register(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("succeed", "Register success");
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        Get.snackbar("Already a member ?", 'This email is already registered.');
        Get.snackbar("Already a member ?", "Please login.");
      } else {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("succeed", "Register success");
      Get.off(HomeView());
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        Get.snackbar("Already a member ?", 'This email is already registered.');
        Get.snackbar("Already a member ?", "Please login.");
      } else {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      Get.snackbar("Success", "Logout successful");
      Get.offAll(() => LoginView());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
