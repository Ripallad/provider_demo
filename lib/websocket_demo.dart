import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketDemo extends StatefulWidget {
  final WebSocketChannel channel;
  const WebSocketDemo({super.key, required this.channel});

  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState();
}

TextEditingController controller = TextEditingController();
List datalist = [];

class _WebSocketDemoState extends State<WebSocketDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    widget.channel.sink.add(controller.text);
                    setState(() {
                      datalist.add(controller.text);
                      controller.text = '';
                    });
                  } else {}
                },
                child: Text("Send")),
            Expanded(
              child: datalist.length > 0
                  ? ListView.builder(
                      itemCount: datalist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("${datalist[index]}"),
                        );
                      })
                  : Container(),
            )
            // StreamBuilder(
            //     stream: widget.channel.stream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         ListView.builder(
            //             itemCount: datalist.length,
            //             itemBuilder: (context, index) {
            //               return ListTile(
            //                 title: Text("${datalist[index]}"),
            //               );
            //             });
            //       }
            //       return Container();
            //     }),
          ],
        ),
      ),
    );
  }
}
