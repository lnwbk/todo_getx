import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_getx/models/todo_model.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;

  final GetStorage _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void addTodo(String title, String subtitle) {
    todoList.add(TodoModel(title, subtitle, false));
    saveTodos();
  }

  void toggleTodo(int index) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
    todoList.refresh();
    saveTodos();
  }

  void deleteTodo(int index) {
    todoList.removeAt(index);
    saveTodos();
  }

  void deleteall() {
    todoList.clear();
    todoList.refresh();
    saveTodos();
  }

  void saveTodos() {
    List<Map<String, dynamic>> todos =
        todoList.map((todo) => todo.toJson()).toList();
    _box.write('todos', todos);
  }

  void loadTodos() {
    List<dynamic> storedTodos = _box.read<List<dynamic>>('todos') ?? [];
    todoList.value =
        storedTodos.map((json) => TodoModel.fromJson(json)).toList();
  }
}
