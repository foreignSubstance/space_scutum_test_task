import 'package:flutter/material.dart';

class ComponentSizes {
  static late final double screenWidth;
  static late final double screenHeight;
  static late final double primaryButtonWidth;
  static late final double primaryButtonHeight;
  static late final double freeSpace;
  static late final double borderWidth;
  static const double defaultPadding = 24;
  static bool _isInitialized = false;

  static final ComponentSizes _sizes = ComponentSizes._();
  factory ComponentSizes() => _sizes;
  ComponentSizes._();

  static void init(BuildContext context) {
    if (_isInitialized) return;
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    primaryButtonWidth = (screenWidth / 2.4).floorToDouble();
    primaryButtonHeight = (screenHeight / 11.7).floorToDouble();
    freeSpace = screenHeight / 17;
    borderWidth = screenHeight / 189;
    _isInitialized = true;
  }
}
