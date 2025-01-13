import 'package:flutter/material.dart';
import 'package:music_app/Views/players/now_playing.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatefulWidget {
  final body;
  final bool? showNowPlaying;
  //app bar text if u don't want to add it then there will be no app bar.
  String? title;

  //  bar;
  CustomScaffold(
      {required this.body,
      this.title,
      this.showNowPlaying,
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
            const SizedBox(
              height: 24,
            ),
            (widget.title != null)
                ? Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.title ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  )
                : Container(),

            Expanded(child: widget.body),
            (widget.showNowPlaying == false)
                ? SizedBox(
                    height: 0,
                  )
                : NowPlaying()
          ],
        ),
      ),
    );
  }
}
