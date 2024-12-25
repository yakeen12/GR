import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Views/auth/login.dart';
import 'package:music_app/Views/splash.dart';
import 'package:music_app/homePage.dart';
import 'package:music_app/utils/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().init(); // تهيئة SharedPreferences
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
//===========================================================================================


