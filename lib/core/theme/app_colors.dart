import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0XFF00679B); //.deepPurple;1b3a57
  static const Color secondary = Color(0XFF249AD5); //.deepPurpleAccent;
  static const Color background = Colors.white;
  static const Color darkBackground = Colors.black;
  static const Color highlight = Color(0XFFffd700);
  static const Color text = Colors.black;
  static const Color textWhite = Colors.white;
  static const Color grey = Colors.grey;
  static const Color error = Colors.red;
  static const Color success = Colors.green;

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [highlight, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, Color(0xFFF5F5F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
