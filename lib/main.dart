import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/favprovider.dart';
import 'package:provider_demo/getx/websocketg.dart';
import 'package:provider_demo/provider/languageprovider.dart';
import 'package:provider_demo/todo/todo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider_demo/websocket_demo.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => favProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LanguageProvider(),
      )
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale('en'), Locale('hi')],
      locale: context.watch<LanguageProvider>().current,
      home: WebsocketgetxScreen(
          channel: IOWebSocketChannel.connect("ws://echo.websocket.org")),
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

class MyLocalization extends StatelessWidget {
  const MyLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.greeting,
            style: TextStyle(fontSize: 25),
          ),
          Text(
            AppLocalizations.of(context)!.welcomeText,
            style: TextStyle(fontSize: 20),
          ),
          InkWell(
            onTap: () {
              context.read<LanguageProvider>().changeLanguage();
              // Provider.of<LanguageProvider>(context, listen: false)
              //     .changeLanguage();
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.blue,
              child: Center(
                child: Text("Change"),
              ),
            ),
          )
        ],
      )),
    );
  }
}
