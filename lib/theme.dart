import 'package:flutter/material.dart';

final defaultTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: const Color(0xff252c4a),
  textTheme: ThemeData().textTheme.copyWith(
        headlineLarge: const TextStyle(
          color: Color(0xff9099c2),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: const TextStyle(
          fontFamily: 'Gluten',
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
);
