import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_getx/controllers/auth_controller.dart';
import 'package:todo_getx/view/register.view.dart';
import 'package:todo_getx/widgets/app_text_field.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(label: 'Email', controller: emailController),
            SizedBox(height: 16),
            AppTextField(
              label: 'Password',
              controller: passwordController,
              hideText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar('Error', 'Invalid email');
                  return;
                }
                if (passwordController.text.length < 6) {
                  Get.snackbar(
                    'Error',
                    'Password must be at least 6 characters',
                  );
                  return;
                }
                authController.login(
                  emailController.text,
                  passwordController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.to(RegisterView());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
