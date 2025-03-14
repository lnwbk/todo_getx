import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/models/todo_model.dart';

class AddTodoView extends StatefulWidget {
  AddTodoView({super.key, this.todo});
  TodoModel? todo;
  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final TodoController todoController = Get.find();

  final TextEditingController textEditingController = TextEditingController();

  final TextEditingController subEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      textEditingController.text = widget.todo!.title;
      subEditingController.text = widget.todo!.subtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todo != null ? "Update Todo" : "Add Todo",
          style: TextStyle(color: Colors.white),
        ),
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
            ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isEmpty) return;
                if (widget.todo != null) {
                  widget.todo!.title = textEditingController.text;
                  widget.todo!.subtitle = subEditingController.text;
                  todoController.updateTodo(widget.todo!);
                } else {
                  todoController.addTodo(
                    textEditingController.text,
                    subEditingController.text,
                  );
                }
                Get.back();
              },
              child: Text("บันทึก"),
            ),
          ],
        ),
      ),
    );
  }
}
