import 'package:clothing_store_app_ui/models/constants.dart';
import 'package:flutter/material.dart';

class App {
  static Color mainc = ColorPalette.yodyyellow;
  static Color sbgc = ColorPalette.white;
  static Color bgc = ColorPalette.ceramicColor;
  static Color mdc = ColorPalette.shadeColor;
  static Color sfgc = ColorPalette.black;
  static Color fgc = ColorPalette.darkColor;

  static darkModeOn() {
    bgc = ColorPalette.darkColor;
    fgc = ColorPalette.white;
  }

  static darkModeOff() {
    bgc = ColorPalette.ceramicColor;
    fgc = ColorPalette.black;
  }
}
