import 'package:flutter/material.dart';

class MyTexts{
  Text errorText(double size){
    return Text("Something Went Wrong! Try Again ...", style: TextStyle(color: Colors.red, fontSize: size, fontFamily: "Roboto-Semibold"),);
  }
}