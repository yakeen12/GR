import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Views/auth/login.dart';

import 'package:music_app/Views/navigation-bar-pages/home.dart';
import 'package:music_app/homePage.dart';
import 'package:music_app/utils/local_storage_service.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      final token = LocalStorageService().getToken();
      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => Home(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => LoginPage(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: GlitchText(
          text: "ЯG",
          style: TextStyle(
            fontSize: 150,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const GlitchText({super.key, required this.text, required this.style});

  @override
  _GlitchTextState createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText> {
  late Timer timer;
  late Random random;
  double glitchOffsetX = 0;
  double glitchOffsetY = 0;
  double glitchOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    random = Random();

    // Periodically update glitch values
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        glitchOffsetX =
            random.nextDouble() * 6 - 3; // Random x offset (-3 to 3)
        glitchOffsetY =
            random.nextDouble() * 6 - 3; // Random y offset (-3 to 3)
        glitchOpacity = random.nextBool() ? 0.5 : 1.0; // Flicker effect
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glitch layer (red)
        Transform.translate(
          offset: Offset(glitchOffsetX, glitchOffsetY),
          child: Opacity(
            opacity: glitchOpacity,
            child: Text(
              widget.text,
              style: widget.style.copyWith(color: Colors.red),
            ),
          ),
        ),
        // Glitch layer (blue)
        Transform.translate(
          offset: Offset(-glitchOffsetX, -glitchOffsetY),
          child: Opacity(
            opacity: glitchOpacity,
            child: Text(
              widget.text,
              style: widget.style.copyWith(color: Colors.blue),
            ),
          ),
        ),
        // Main text
        Text(
          widget.text,
          style: widget.style,
        ),
      ],
    );
  }
}
