import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomFlushBar(String titleFlush, String messageFlush, BuildContext ctx) async {
  return Flushbar(
    title: titleFlush,
    message: messageFlush,
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor:Colors.red,
    isDismissible: false,
    duration: const Duration(seconds: 4),
    icon: const Icon(
      Icons.error,
      color: Colors.black,
      size: 30,
    ),
  ).show(ctx);
}
