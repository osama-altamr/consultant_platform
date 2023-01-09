import 'package:flutter/material.dart';

InputDecoration CustomInputDecoration(String title, Widget? icon) {
  return InputDecoration(
    label: Text(
      title,
      style: const TextStyle(fontFamily: 'Arvo', color: Colors.white),
    ),
    
    prefixIcon: icon,
    focusColor: Colors.white,
    contentPadding: const EdgeInsets.all(8),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          18,
        ),
        borderSide: const BorderSide(
          color: Colors.amber,
        )),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          18,
        ),
        borderSide: const BorderSide(
          color: Colors.grey,
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          18,
        ),
        borderSide: const BorderSide(
          color: Colors.grey,
        )),
    
  );
}
