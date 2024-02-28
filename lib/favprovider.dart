import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_demo/todo/todomodel.dart';

class favProvider with ChangeNotifier {
  List favlist = [];
  List todolist = [];

  bool isDataLoaded = false;

  addToList(index) {
    favlist.add(index);
    notifyListeners();
  }

  removeFromList(index) {
    favlist.remove(index);
    notifyListeners();
  }

  // todoapi() async {
  //   var url = "https://dummyjson.com/todos";
  //   var responce = await http.get(Uri.parse(url));
  //   try {
  //     var decode = jsonDecode(responce.body);
  //     var data = decode['todos'];
  //     var mylist = data.Map((e) => Todo.fromMap(e)).toList();
  //     todolist.clear();
  //     todolist.addAll(mylist);
  //     print(todolist);

  //     notifyListeners();
  //   } catch (e) {
  //     e.toString();
  //   }
  // }

  todoapi() async {
    try {
      var url = "https://dummyjson.com/todos";
      var responce = await http.get(Uri.parse(url));
      var decodedata = jsonDecode(responce.body);
      print(decodedata);
      var data = decodedata['todos'];

      print(data);
      var list = data.map((m) => Todo.fromMap(m)).toList();
      print(list);
      todolist.clear();
      todolist.addAll(list);
      print(todolist);
      isDataLoaded = true;
      notifyListeners();
      print(todolist);
    } catch (error) {
      error.toString();
    }
  }
}
