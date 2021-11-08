import 'package:flutter/material.dart';
import 'package:frontend/controller/todo_controller.dart';
import 'package:frontend/screens/add_edit_screen.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var todocontroller = Get.put(TodoController());
  @override
  void didChangeDependencies() {
    todocontroller.getTodoData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Todo App'),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => AddEditScreen(
                      id: 1,
                    ));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<TodoController>(
            init: TodoController(),
            builder: (controller) => todocontroller.loading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: todocontroller.todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      var todoData = todocontroller.todos[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    todoData.id.toString(),
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 20),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    todoData.title,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async{
                                    await  todocontroller.deleteTodo(todoData.id);
                                    todocontroller.getTodoData();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
