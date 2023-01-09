// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chatscreen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});
  static const routeName = '/chats_screen';

  @override
  Widget build(BuildContext context) {
    List<ChatExpert> chat = [
      ChatExpert(
          id: 1,
          name: "Ali Assad",
          msg: "how are you",
          dateTime: DateFormat('hh:mm a')
              .format(DateTime.now().add(const Duration(hours: 2)))
              .toString(),
          profileImage: 'assets/images/ali.jpg'),
      ChatExpert(
          id: 2,
          name: "Leo Messi",
          msg: "I Love you",
          dateTime: DateFormat('hh:mm a')
              .format(DateTime.now().add(const Duration(hours: 1)))
              .toString(),
          profileImage: 'assets/images/profile.jpg'),
      ChatExpert(
          id: 3,
          name: "Federico Chiesa",
          msg: "Hello Osama",
          dateTime: DateFormat('hh:mm a')
              .format(DateTime.now().add(const Duration(hours: 4)))
              .toString(),
          profileImage: 'assets/images/Federico.jpg'),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            margin: EdgeInsets.only(top: 20, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
                  child: Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.amber,
                      fontFamily: 'Courgette',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                      itemCount: chat.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return ChatScreen(
                                      id: chat[index].id,
                                      name: chat[index].name,
                                      imageProfile: chat[index].profileImage);
                                }));
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage(chat[index].profileImage),
                                  radius: 25,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 9.0),
                                  child: Text(
                                    chat[index].name,
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    chat[index].msg,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                trailing: Text(
                                  chat[index].dateTime,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.amber,
                              endIndent: 20,
                              indent: 20,
                            )
                          ],
                        );
                      }),
                ))
              ],
            )),
      ),
    );
  }
}

class ChatExpert {
  final int id;
  final String name;
  final String msg;
  final String dateTime;
  final String profileImage;
  ChatExpert({
    required this.id,
    required this.name,
    required this.msg,
    required this.dateTime,
    required this.profileImage,
  });
}
