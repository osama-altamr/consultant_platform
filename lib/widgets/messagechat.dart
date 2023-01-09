import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.message,
    required this.isMe,
    required this.dateTime,
  });

  final String message;

  final bool isMe;
  String dateTime;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(isMe ? 0 : 14),
                    bottomRight: Radius.circular(isMe ? 14 : 0),
                  ),
                  color: isMe ? Colors.amber : Colors.grey[300]),
              child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).textTheme.headline6!.color,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment:
                          isMe ? MainAxisAlignment.end : MainAxisAlignment.end,
                      children: [
                        Text(
                          dateTime,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ],
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
