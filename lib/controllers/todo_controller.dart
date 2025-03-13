import 'package:get/get.dart';
import 'package:todo_getx/controllers/auth_controller.dart';
import 'package:todo_getx/models/todo_model.dart';
import 'package:todo_getx/services/storage_services.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;
  StorageService storageService = StorageService();
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    fetchtodos();
  }

  Future<void> fetchtodos() async {
    var todos = await storageService.read(
      'todolist',
      authController.user.value?.uid ?? '',
    );
    if (todos != null) {
      todoList.value = List<TodoModel>.from(
        todos.map((x) => TodoModel.fromJson(x)),
      );
    }
  }

  void addTodo(String title, String subtitle) {
    TodoModel todo = TodoModel(
      title,
      subtitle,
      false,
      uid: authController.user.value?.uid,
    );
    todoList.add(todo);
    storageService.write('todolist', todo.toJson());
  }

  void toggleTodo(int index) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
    todoList.refresh();
  }

  void deleteTodo(int index) {
    todoList.removeAt(index);
  }

  void deleteall() {
    todoList.clear();
  }

  void loadTodos() async {}
}
