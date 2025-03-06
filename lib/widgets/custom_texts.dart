import 'package:flutter/material.dart';

import '../ui_helper.dart';

class CustomTexts{
  static Text h6 ({required String text, Color color = Colors.white, double size = 22}){
    return Text(
      text,
      style: TextStyle(
          color:color,
          fontSize: size,
          fontFamily: "Roboto-Semibold"),
    );
  }

  static Text bigAmountText (String amount){
    return Text(
      "$amount₹",
      style: TextStyle(
          color: Colors.red,
          fontSize: 40,
          fontFamily: "Lato-Bold",
          fontWeight: FontWeight.bold),
    );
  }

  static Text h1({required String text, double size = 50}){
    return Text(
      text,
      style: TextStyle(
          color: UiHelper.primaryColor,
          fontSize: size,
          fontFamily: "Lato-Bold"),
    );
  }

}