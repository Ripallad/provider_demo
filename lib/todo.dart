import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/favprovider.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    var todo = context.watch<favProvider>().todolist;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todo[index].todo.toString()),
          );
        },
      ),
    );
  }
}
