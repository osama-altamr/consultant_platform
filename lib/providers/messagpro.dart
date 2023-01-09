import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Message {
  String message;
  bool isMe;
  String dateTime;
  Message({
    required this.message,
    required this.isMe,
    required this.dateTime,
  });
}

class MessageProvider with ChangeNotifier {
  List<Message> messages = [
    Message(
      message:
          'McClintocks eye for detail certainly helped narrow the whereabouts of lorem ipsums origin, however, thehow and when still remain',
      isMe: true,
      dateTime: '6:20 Pm',
    ),
    Message(
        message:
            'From its medieval origins to the digital era, learn everything there is',
        isMe: false,
        dateTime: '5:34 Pm'),
    Message(message: 'Hello how are you', isMe: true, dateTime: '5:23 Pm'),
    Message(
        message:
            'From its medieval origins to the digital era, learn everything there is',
        isMe: false,
        dateTime: '5:34 Pm'),
    Message(
        message:
            'The passage experienced again during the 90s as desktop publishers bundled ',
        isMe: true,
        dateTime: '6:00 Pm'),
    Message(message: 'Richard McClintock,', isMe: false, dateTime: '6:10 Pm'),
    Message(
      message:
          'In particular, the garbled words of lorem ipsum bear an unmistakable resemblance to sections 1.10.32–33 of Cicero',
      isMe: true,
      dateTime: '6:17 Pm',
    ),
    Message(
      message:
          'What I find remarkable is that this text has been the industrys standard dummy text ever since some printer in the 1500s took a galley of type and scrambled it to make a type specimen book',
      isMe: false,
      dateTime: '6:20 Pm',
    ),
    Message(
      message:
          'McClintocks eye for detail certainly helped narrow the whereabouts of lorem ipsums origin, however, thehow and when still remain',
      isMe: true,
      dateTime: '6:20 Pm',
    )
  ];

  sendMessage(String msg) {
    messages.insert(
        0,
        Message(
            message: msg,
            isMe: true,
            dateTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(hours: 2)))
                .toString()));

    notifyListeners();
  }
}
