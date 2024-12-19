import 'package:flutter/material.dart';

class CustomScaffold extends StatefulWidget {
  final body;

  //app bar text if u don't want to add it then there will be no app bar.
  String? title;

  //  bar;
  CustomScaffold(
      {required this.body,
      this.title,
      // required this.bar,
      super.key});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  Widget? body;
  String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 80, 17, 13)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            // Custom AppBar
            (widget.title != null)
                ? Container(
                    height: 90,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.title ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : Container(),

            Expanded(child: widget.body),
          ],
        ),
      ),
    );
  }
}
