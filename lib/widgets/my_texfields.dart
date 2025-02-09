import 'dart:core';

import 'package:flutter/material.dart';
import '../ui_helper.dart';

class MyTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final bool? isUnderlined;
  final bool isPassword;
  final bool isFilled;
  final bool? readOnly;
  final Icon? prefix;
  final Widget? suffix;
  final VoidCallback? suffixCallback;
  final VoidCallback? onTap;
  final Color? enabledColor;
  final Color? focusedColor;
  final double? borderRadius;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.controller,
    required this.isPassword,
    this.label,
    this.isFilled = false,
    this.isUnderlined,
    this.prefix,
    this.enabledColor,
    this.focusedColor,
    this.borderRadius,
    this.hint,
    this.readOnly = false,
    this.suffix,
    this.suffixCallback,
    this.onTap,
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
      readOnly: widget.readOnly!,
      controller: widget.controller,
      onTap: widget.onTap,
      decoration: InputDecoration(
          filled: widget.isFilled,
          fillColor: UiHelper.grey,
          border: widget.isUnderlined != null
              ? UnderlineInputBorder()
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 15.0),
                ),
          enabledBorder: widget.isUnderlined != null
              ? UnderlineInputBorder(
                borderSide: BorderSide(color: UiHelper.primaryColor)
          )
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 15.0),
                  borderSide: BorderSide(
                      color: widget.enabledColor ?? UiHelper.primaryColor),
                ),
          focusedBorder: widget.isUnderlined != null
              ? UnderlineInputBorder(
              borderSide: BorderSide(color: UiHelper.secondaryColor)
          )
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 15.0),
                  borderSide: BorderSide(
                      color: widget.focusedColor ?? UiHelper.secondaryColor)),
          label: widget.label != null ? Text(widget.label!) : null,
          hintText: widget.hint,
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isShowing = !isShowing;
                    });
                  },
                  icon:
                      Icon(isShowing ? Icons.visibility : Icons.visibility_off))
              : widget.suffix),
    );
  }
}
