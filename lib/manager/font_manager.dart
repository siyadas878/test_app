import 'package:flutter/material.dart';
import 'package:test_app/manager/color_manager.dart';

AppFont appFont = AppFont();

class AppFont {
  final TextStyle f20w500Black = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  final TextStyle f17w500Primary = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, color: appColors.brandDark);
}
