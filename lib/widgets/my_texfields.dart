import 'dart:core';

import 'package:flutter/material.dart';
import '../ui_helper.dart';

class MyTextField extends StatefulWidget {

  final String label;
  final bool? isUnderlined;
  final bool isPassword;
  final bool isFilled;
  final Icon? prefix;
  final Color? enabledColor;
  final Color? focusedColor;
  final double? borderRadius;
  final TextEditingController controller;

   const MyTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isPassword,
    this.isFilled = false,
    this.isUnderlined,
    this.prefix,
    this.enabledColor,
    this.focusedColor,
    this.borderRadius,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  // variable to handle the password obscure
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isShowing,
      controller: widget.controller,
      decoration: InputDecoration(
          filled: widget.isFilled,
          fillColor: UiHelper.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.0),
            borderSide: BorderSide(color: widget.enabledColor ?? UiHelper.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.0),
              borderSide:
              BorderSide(color: widget.focusedColor ?? UiHelper.secondaryColor)),
          label: Text(widget.label),
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPassword == true ? IconButton(
              onPressed: () {
                setState(() {
                  isShowing = !isShowing;
                });
              },
              icon: Icon(isShowing ? Icons.visibility : Icons.visibility_off)
          ) : null
      ),
    );
  }
}
