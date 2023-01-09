// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.function,
    required this.tag,
    required this.colorIcon,
  }) : super(key: key);

  final Color colorIcon;
  final IconData icon;
  final String tag;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.0,
        child: FloatingActionButton(
          heroTag: tag,
          backgroundColor: Colors.white,
          mini: true,
          child: Icon(
            icon,
            color: colorIcon,
          ),
          onPressed: () => function,
        ));
  }

  /* 
  InkWell(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.redAccent,
                  Colors.redAccent.shade700,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          onTap: () => function,
        ) */
}
