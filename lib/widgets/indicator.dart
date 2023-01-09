import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
          buildContainer(context, 3),
          buildContainer(context, 4),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {

    return Container(
      margin: const EdgeInsets.all(4),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: index == i ? Color(0xFFB48A36): Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
