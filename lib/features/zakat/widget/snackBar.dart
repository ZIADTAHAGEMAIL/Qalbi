import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../shared/widget/customText.dart';
extension SnackBarExtension on BuildContext{
void showSnackBar(BuildContext context ,String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Customtext(
        text: message,
        textcolor: Colors.white,
        textsize: 14,
        textweight: FontWeight.bold,
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ),
  );
}}