import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_demo/todomodel.dart';

class favProvider with ChangeNotifier {
  List favlist = [];
  List todolist = [];
  addToList(index) {
    favlist.add(index);
    notifyListeners();
  }

  removeFromList(index) {
    favlist.remove(index);
    notifyListeners();
  }

  api() async {
    var url = "https://dummyjson.com/todos";
    var responce = await http.get(Uri.parse(url));
    try {
      var decode = jsonDecode(responce.body);
      var data = decode['todos'];
      var mylist = data.Map((e) => Todo.fromMap(e)).toList();
      // todolist.clear();
      mylist.addAll(todolist);

      notifyListeners();
     // log(todolist.toString());
    } catch (e) {
      e.toString();
    }
  }
}
