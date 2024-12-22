import 'package:flutter/material.dart';

class Me extends StatefulWidget  {
  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Me', style: TextStyle(fontSize: 24, color: Colors.white)));
  }
}