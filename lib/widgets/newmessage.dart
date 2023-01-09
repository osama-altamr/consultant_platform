import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/messagpro.dart';
import 'package:tutorial_app/widgets/textformfield.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController _controller = TextEditingController();
  String _enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 5),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            cursorColor: Colors.amber,
            style: const TextStyle(
              color: Colors.white,
            ),
            //    textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
            controller: _controller,
            decoration: CustomInputDecoration('', null).copyWith(
              hintText: 'Send a message...',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        IconButton(
          color: Colors.amber,
          disabledColor: Colors.grey,
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(
            Icons.send,
          ),
        )
      ]),
    );
  }

  void _sendMessage() {
    _controller.clear();
    Provider.of<MessageProvider>(context, listen: false)
        .sendMessage(_enteredMessage);
    //  setState(() {});
  }
}



  //  InputDecoration(
  //             hintStyle: TextStyle(
  //               color: Colors.amber,
  //             ),
  //             enabledBorder: UnderlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.amber)),
  //             hintText: ' Send a message...',
  //           ),