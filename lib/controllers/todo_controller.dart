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

  Future<void> addTodo(String title, String subtitle) async {
    TodoModel todo = TodoModel(
      title,
      subtitle,
      false,
      uid: authController.user.value?.uid,
    );
    String docId = await storageService.write('todoList', todo.toJson());
    todo.docid = docId;
    todoList.add(todo);
  }

  void toggleTodo(int index) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
    todoList.refresh();
    storageService.update('todoList', todoList[index].docid ?? '', {
      'isCompleted': todoList[index].isCompleted,
    });
  }

  void deleteTodo(String docid) {
    todoList.removeWhere((todo) => todo.docid == docid);
    storageService.delete('todoList', docid);
  }

  void deleteall() {
    todoList.clear();
  }

Future<void> updateTodo(TodoModel todo) async {
  todoList.firstWhere((todo) => todo.docid == todo.docid).title;
  todoList.firstWhere((todo) => todo.docid == todo.docid).subtitle;
  todoList.refresh();
  await storageService.update('todoList',todo.docid ?? '', todo.toJson());}
}


  void loadTodos() async {}

