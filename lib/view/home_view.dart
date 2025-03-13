import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/view/add_todo_view.dart';

import '../models/todo_model.dart';

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
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
                onPressed: () => todoController.deleteTodo(index),
                icon: Icon(Icons.delete),
              ),
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
