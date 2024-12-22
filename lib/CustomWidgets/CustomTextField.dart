import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final hintText;
  final controller;
  bool? isPassword;

  CustomTextField(
      {required this.controller,
      required this.hintText,
      this.isPassword,
      super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color.fromARGB(52, 158, 158, 158)));
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        cursorColor: Color.fromARGB(52, 158, 158, 158),
        style: const TextStyle(color: Colors.white),
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 96, 75, 75)),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: widget.isPassword ?? true,
      ),
    );
  }
}
