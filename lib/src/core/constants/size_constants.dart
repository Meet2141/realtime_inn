import 'package:flutter/material.dart';

class SizeConstants {
  static const double extraSmall = 12;
  static const double small = 14;
  static const double medium = 16;
  static const double large = 18;
  static const double extraLarge = 20;
}

Widget vSpace([double size = 16]) => SizedBox(height: size);

Widget hSpace([double size = 16]) => SizedBox(width: size);
