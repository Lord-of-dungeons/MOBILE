import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? pixelRatio;
  static double? screenWidth;
  static double? screenHeight;
  static double? statusBarHeight;
  static double? bottomBarHeight;
  static double? textScaleFactor;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    statusBarHeight = WidgetsBinding.instance!.window.padding.top;
    bottomBarHeight = WidgetsBinding.instance!.window.padding.bottom;
    textScaleFactor = WidgetsBinding.instance!.window.textScaleFactor;
    orientation = _mediaQueryData!.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Get screen height
double getScreenHeight() {
  return SizeConfig.screenHeight!;
}

// Get screen width
double getScreenWidth() {
  return SizeConfig.screenWidth!;
}
