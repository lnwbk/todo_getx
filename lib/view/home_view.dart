import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/auth_controller.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/view/add_todo_view.dart';

import '../models/todo_model.dart';

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final AuthController authController = Get.put(AuthController());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    todoController.fetchtodos();
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              todoController.deleteall();
              authController.logout();
            },
          ),
        ],
      ),

      body: Obx(
        () => ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            TodoModel todo = todoController.todoList[index];
            return ListTile(
              title: Text(todoController.todoList[index].title),
              subtitle: Text(todoController.todoList[index].subtitle),
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) => todoController.toggleTodo(index),
              ),
              trailing: IconButton(
                onPressed: () => todoController.deleteTodo(todo.docid ?? ''),
                icon: Icon(Icons.delete),
              ),
              onTap: (){
                Get.to(AddTodoView(todo: todo));
              }
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => Get.to(() => AddTodoView()),
            heroTag: 'add',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () => todoController.deleteall(),
            heroTag: 'delete',
            child: Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
