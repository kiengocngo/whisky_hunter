import 'package:flutter/material.dart';

class TMColors {
  TMColors._();
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color.fromARGB(0, 9, 8, 8);

  static LinearGradient gradient = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFaa4b6b),
      Color(0xFF6b6b83),
      Color(0xFF3b8d99),
    ],
  );
  static const Color backgroundColor = Color(0xFFF0D588);
}
