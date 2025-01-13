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
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 18, 4, 4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: const Color.fromARGB(255, 104, 2, 2),
        elevation: 22,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: SizedBox(
          child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
      )),
    );
  }
}
