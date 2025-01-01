import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/customSongCard.dart';
import 'package:music_app/Models/playList_model.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class MyPlaylistinside extends StatefulWidget {
  final Playlist songlist;
  const MyPlaylistinside({
    super.key,
    required this.songlist,
  });
  @override
  State<MyPlaylistinside> createState() => _MyPlaylistinsideState();
}

class _MyPlaylistinsideState extends State<MyPlaylistinside> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(
      context,
    );

    // musicProvider.setPlaylist(widget.songlist.songs);
    // musicProvider.setCurrentIndex(0);

    return CustomScaffold(
      title: widget.songlist.name,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.add_outlined,
                  color: Color.fromARGB(255, 100, 28, 11)),
              const SizedBox(width: 14),
              const Icon(Icons.edit, color: Color.fromARGB(255, 114, 12, 12)),
              const SizedBox(width: 14),
              const Icon(Icons.shuffle,
                  color: Color.fromARGB(255, 114, 12, 12)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.play_circle_fill,
                    color: Color.fromARGB(255, 94, 17, 13), size: 48),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
                itemCount: widget.songlist.songs.length,
                itemBuilder: (context, index) {
                  return CustomSongCardPlayList(
                    playListId: widget.songlist.id,
                    song: widget.songlist.songs[index],
                    onTap: () {
                      musicProvider.setPlaylistAndSong(
                        widget.songlist.songs, // البلاي ليست الحالية
                        index, // الـ Index للأغنية
                      );
                      // تعيين قائمة الأغاني في البروفايدر
                      // musicProvider.setCurrentIndex(0);
                      // إذا كانت الأغنية الحالية هي نفسها الأغنية التي نقر عليها، نكمل تشغيلها من نفس المكان
                      // musicProvider.setCurrentIndex(index);
                      // if (musicProvider.currentSongId ==
                      //     widget.songlist.songs[index].id) {
                      //   print(
                      //       "${musicProvider.currentSongId} == ${widget.songlist.songs[index].id}");
                      //   musicProvider.setPlaylist(widget.songlist.songs);

                      //   if (musicProvider.isPlaying) {
                      //     printError(info: "is playing");
                      //   } else {
                      //     printError(info: "resume");
                      //     musicProvider.resumeSong();
                      //   } // لا نقوم بإعادة تشغيل الأغنية إذا كانت بالفعل قيد التشغيل
                      // } else {
                      //   musicProvider.setPlaylist(widget.songlist.songs);
                      //   musicProvider.currentIndex =
                      //       index; // تحديث مؤشر الأغنية
                      //   // تشغيل أول أغنية تلقائيًا

                      //   musicProvider.playSong();
                      // }

                      // استدعاء MusicPlayer كـ BottomSheet
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return const MusicPlayer(); // صفحة الـ MusicPlayer
                        },
                      );
                    },
                    moreOnTap: () async {
                      final PlaylistViewModel playlistViewModel =
                          PlaylistViewModel();

                      await playlistViewModel.removeSongFromPlaylist(
                          widget.songlist.id,
                          widget.songlist.songs[index].id,
                          LocalStorageService().getToken()!); // أرسل الطلب
                      print(playlistViewModel.errorMessage.value);
                      if (!playlistViewModel.isLoading.value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Song removed from playList')));
                        return;
                      }
                      setState(() {});
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
