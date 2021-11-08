import 'package:flutter/material.dart';
import 'package:frontend/controller/todo_controller.dart';
import 'package:get/get.dart';

class AddEditScreen extends StatefulWidget {
  final int id;
  const AddEditScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}
var todoController = Get.put(TodoController());
var textController = TextEditingController();

void addTodo() async {
  if (textController.text.isEmpty) {
    return;
  }
  print(textController.text);
  todoController.addNewTodo(textController.text);
  Get.back();
}

class _AddEditScreenState extends State<AddEditScreen> {
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.id != null ? 'Edit Todo' : 'Add Todo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(hintText: 'Add Todo'),
              ),
              ElevatedButton(
                  onPressed: () {
                     addTodo();
                    todoController.getTodoData();
                  },
                  child: const Text('Add Todo'))
            ],
          ),
        ),
      ),
    );
  }
}
