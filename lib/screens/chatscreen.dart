// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/messagpro.dart';

import '../widgets/messagechat.dart';
import '../widgets/newmessage.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.imageProfile});
  final int id;
  final String name;
  final String imageProfile;

  @override
  Widget build(BuildContext context) {
    List<Message> message = Provider.of<MessageProvider>(context).messages;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            margin: EdgeInsets.only(top: 20, left: 6, right: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: FloatingActionButton(
                        backgroundColor: Colors.black,
                        mini: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(imageProfile),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const Text(
                            'last seen today at 5:00 PM',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 0.9,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            color: Colors.amber,
                          )),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Transform.scale(
                      scale: 0.9,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.video_call,
                            color: Colors.amber,
                          )),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.amber,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      reverse: true,
                      itemBuilder: ((context, index) {
                        return MessageBubble(
                          message: message[index].message,
                          isMe: message[index].isMe,
                          dateTime: message[index].dateTime,
                        );
                      }),
                      itemCount: message.length,
                    ),
                  ),
                ),
                NewMessage()
              ],
            )),
      ),
    );
  }
}
