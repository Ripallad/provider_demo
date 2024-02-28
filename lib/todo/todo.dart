import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/favprovider.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    final myprovider = Provider.of<favProvider>(context, listen: false);
    myprovider.todoapi();
    final list = myprovider.favlist;
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return ListTile(
              // title: Text(list[index].todo),
              );
        },
      ),
    );
  }
}

class MyTodoList extends StatelessWidget {
  const MyTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: Consumer<favProvider>(
        builder: (context, todoProvider, child) {
          if (!todoProvider.isDataLoaded) {
            todoProvider.todoapi();
          }
          var data = todoProvider.todolist;
          return ListView.builder(
              itemCount: todoProvider.todolist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${data[index].todo}'),
                );
              });
        },
      ),
    );
  }
}
