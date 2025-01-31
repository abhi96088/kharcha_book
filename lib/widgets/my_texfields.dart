import 'dart:core';

import 'package:flutter/material.dart';
import '../my_colors.dart';

class MyTextField extends StatefulWidget {

  final String label;
  final bool? isUnderlined;
  final bool isPassword;
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

  // variable to handle the password obsecure
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isShowing,
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.0),
            borderSide: BorderSide(color: widget.enabledColor ?? MyColors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.0),
              borderSide:
              BorderSide(color: widget.focusedColor ?? MyColors.secondaryColor)),
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
