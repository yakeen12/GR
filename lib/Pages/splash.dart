import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_app/Pages/login.dart';
import 'package:music_app/homePage.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
       (_)=> LoginPage(),
       ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 80, 17, 13)],
      ),
      ),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the column vertically
            children: [
              Image.asset(
                'assets/images/GR_logo.png', // Replace with your asset path
                width: 300, // Set width if needed
                height: 300, // Set height if needed
              ),
            ],
          ),
    ),
    );
  }
}