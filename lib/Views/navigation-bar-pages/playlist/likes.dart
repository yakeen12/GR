import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/customSongCard.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class Likes extends StatelessWidget {
  final UserViewModel userViewModel = Get.find<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    String token = LocalStorageService().getToken() ?? "";

    userViewModel.fetchLikedSongs(token);

    return CustomScaffold(
      title: 'Liked Songs',
      body: Obx(() {
        if (userViewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (userViewModel.likedSongs.isEmpty) {
          return Center(child: Text('No liked songs found.'));
        } else {
          return ListView.builder(
            itemCount: userViewModel.likedSongsList.length,
            itemBuilder: (context, index) {
              final song = userViewModel.likedSongsList[index];
              return CustomSongCardPlayList(
                onTap: () {
                  // تعيين قائمة الأغاني في البروفايدر
                  musicProvider.setPlaylist(userViewModel.likedSongsList);
                  
                  // إذا كانت الأغنية الحالية هي نفسها الأغنية التي نقر عليها، نكمل تشغيلها من نفس المكان
                  if (musicProvider.currentSongId == song.id) {
                    if (musicProvider.isPlaying) {
                      printError(info: "is playing");
                    } else {
                      printError(info: "resume");
                      musicProvider.resumeSong();
                    } // لا نقوم بإعادة تشغيل الأغنية إذا كانت بالفعل قيد التشغيل
                  } else {
                    musicProvider.currentIndex = index; // تحديث مؤشر الأغنية
                    // تشغيل أول أغنية تلقائيًا

                    musicProvider.playSong();
                  }

                  // استدعاء MusicPlayer كـ BottomSheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return MusicPlayer(); // صفحة الـ MusicPlayer
                    },
                  );
                },
                song: song,
              );
            },
          );
        }
      }),
    );
  }
}
