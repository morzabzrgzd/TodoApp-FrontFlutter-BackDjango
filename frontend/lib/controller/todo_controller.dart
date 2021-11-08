import 'dart:developer';

import 'package:frontend/models/todo_model.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  List todos = [];
  bool loading = false;

  Future getTodoData() async {
    loading = true;
    var url = Uri.http('10.0.2.2:8000', '/api/todo/');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List;
      List<Todo> getTodo = [];
      for (var element in jsonResponse) {
        Todo todo = Todo(
          id: element['id'],
          title: element['title'],
        );
        getTodo.add(todo);
      }
      todos = getTodo;
      loading = false;
      print('Data Found');
    } else {
      print('No Data Found');
    }
    update();
  }

  Future addNewTodo(String title) async {
    try {
      var url = Uri.http('10.0.2.2:8000', '/api/todo/');
      http.Response response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: convert.jsonEncode({
            "title": title,
          }));

      print(response.body);
    } catch (e) {
      print(e);
    }
    update();
  }

  Future deleteTodo(int id)async{
    var url = Uri.http('10.0.2.2:8000', '/api/todo/$id/');
    try {
      http.Response response =await http.delete(url);
      if (response.statusCode>400) {
        print('Data Not Delete');
      }else{
        print(response.body);
      }
    } catch (e) {
      print('Dta Not Deleted');
    }
  }
}
