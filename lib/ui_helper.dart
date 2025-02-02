import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UiHelper{
  /// ---------> Colors <---------- ///
  static Color bgColor = Color(0XFFF1F0F0);
  static Color primaryColor = Color(0XFF38B6FF);
  static Color secondaryColor = Color(0XFF89C400);
  static Color grey = Color(0XFFD9D9D9);

  void snackBar (BuildContext context, String text, Color color, Color bgColor){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          text,
          style: TextStyle(color: color, fontSize: 18, fontFamily: "Roboto-Semibold"
          ),),
          backgroundColor: bgColor,
        ),
    );
  }
}