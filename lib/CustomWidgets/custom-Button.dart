import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final onPressed;
  final text;

  const CustomButton({required this.onPressed, required this.text, super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
      },
      child: SizedBox(
          child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      )),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 6,
        primary: Color.fromARGB(255, 104, 2, 2),
        onPrimary: Color.fromARGB(255, 18, 4, 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
