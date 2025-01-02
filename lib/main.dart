import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/splash.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => UserViewModel());
  await LocalStorageService().init(); // تهيئة SharedPreferences

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PodcastProvider(),
          
        ), // ChangeNotifier للميوزيك بلاير
        ChangeNotifierProvider(
          create: (_) => MusicProvider(),
          
        ), // ChangeNotifier للميوزيك بلاير
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
//===========================================================================================


