import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider_demo/getx/controller.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketgetxScreen extends StatelessWidget {
  final WebSocketChannel channel;
  const WebsocketgetxScreen({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    final gcontroller = Get.put(Getcontroller());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: Text(
            "Websocket Getx",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: gcontroller.controller,
              ),
              TextButton(
                onPressed: () {
                  if (gcontroller.controller.text.isNotEmpty) {
                    channel.sink.add(gcontroller.controller.text);
                    gcontroller.datalist.add(gcontroller.controller.text);
                    gcontroller.controller.text = '';
                  } else {}
                },
                child: Text("Send"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: gcontroller.datalist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        gcontroller.datalist[index],
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            gcontroller.datalist
                                .remove(gcontroller.datalist[index]);
                          },
                          icon: Icon(Icons.cancel_outlined)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
