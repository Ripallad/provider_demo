import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/favprovider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketProvider extends StatelessWidget {
  final WebSocketChannel channel;
  const WebsocketProvider({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    final datalist = context.read<favProvider>().datalist;
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "Websocket Provider",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  channel.sink.add(controller.text);
                  context.read<favProvider>().datalist.add(controller.text);
                  controller.text = '';
                } else {}
                ;
              },
              child: Text("Send"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: datalist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(datalist[index]),
                    trailing: IconButton(
                        onPressed: () {
                          datalist.remove(datalist[index]);
                        },
                        icon: Icon(Icons.cancel_outlined)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
