import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/favprovider.dart';
import 'package:provider_demo/todo.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => favProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Todo(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var mylist = context.watch<favProvider>().favlist;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FavScreen()));
        },
        child: Icon(Icons.favorite_outline),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Index $index"),
              trailing: IconButton(
                  onPressed: () {
                    if (mylist.contains(index)) {
                      context.read<favProvider>().removeFromList(index);
                    } else {
                      context.read<favProvider>().addToList(index);
                    }
                  },
                  icon: Icon(mylist.contains(index)
                      ? Icons.favorite
                      : Icons.favorite_outline)),
            );
          }),
    );
  }
}

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var favlist = context.watch<favProvider>().favlist;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: favlist.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${favlist[index]}'),
            );
          }),
    );
  }
}
