import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo_controller.dart';

class AddTodoView extends StatelessWidget {
  final TodoController todoController = Get.find();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController subEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
        child: Column(
          children: [
            const Text("Title"),
            TextField(controller: textEditingController),
            const SizedBox(height: 15),
            const Text("SubTitle"),
            TextField(controller: subEditingController),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  todoController.addTodo(
                    textEditingController.text,
                    subEditingController.text,
                  );
                  Get.back();
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
