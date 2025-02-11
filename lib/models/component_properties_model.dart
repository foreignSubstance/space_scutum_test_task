import 'package:flutter/material.dart';

class ComponentSizes {
  static late final double screenWidth;
  static late final double screenHeight;
  static late final double buttonWidth;
  static late final double buttonHeight;
  static late final double freeSpace;
  static late final double borderWidth;
  static late final double dialogWidth;
  static late final double dialogHeight;
  static const double defaultPadding = 24;
  static const double defaultRadius = 24;
  static const double indexRadius = 48;
  static bool _isInitialized = false;

  static final ComponentSizes _sizes = ComponentSizes._();
  factory ComponentSizes() => _sizes;
  ComponentSizes._();

  static void init(BuildContext context) {
    if (_isInitialized) return;
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    buttonWidth = (screenWidth / 2.4).floorToDouble();
    buttonHeight = (screenHeight / 11.7).floorToDouble();
    freeSpace = screenHeight / 17;
    borderWidth = screenHeight / 189;
    dialogWidth = screenWidth - 2 * defaultPadding;
    dialogHeight = dialogWidth / 2.5;
    _isInitialized = true;
  }
}

abstract class ComponentColors {
  static const primaryRed = Color(0xfffc2e20);
  static const accentRed = Color(0xff940000);
  static const primaryOrange = Color(0xfff9943b);
  static const accentOrange = Color(0xffd05301);
  static const primaryBlue = Color(0xff65acf0);
  static const accentBlue = Color(0xff2a72c3);
  static const primaryGreen = Color(0xff03a65a);
  static const accentGreen = Color(0xff005e38);
  static const primaryButtonBlue = Color(0xff107eeb);
  static const accentButtonBlue = Color(0xff2d8ded);
}
