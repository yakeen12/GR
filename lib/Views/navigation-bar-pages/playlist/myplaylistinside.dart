import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/customSongCard.dart';
import 'package:music_app/Models/playList_model.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/artist.dart';
import 'package:music_app/providers/music_provider.dart';
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
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    return CustomScaffold(
      title: '${widget.songlist.name}',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Row(
            children: [
              Icon(Icons.add_outlined, color: Color.fromARGB(255, 100, 28, 11)),
              SizedBox(width: 14),
              Icon(Icons.edit, color: Color.fromARGB(255, 114, 12, 12)),
              SizedBox(width: 14),
              Icon(Icons.shuffle, color: Color.fromARGB(255, 114, 12, 12)),
              Spacer(),
              IconButton(
                icon: Icon(Icons.play_circle_fill,
                    color: Color.fromARGB(255, 94, 17, 13), size: 48),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
                itemCount: widget.songlist.songs.length,
                itemBuilder: (context, index) {
                  return CustomSongCardPlayList(
                    song: widget.songlist.songs[index],
                    onTap: () {
                      // تعيين قائمة الأغاني في البروفايدر
                      musicProvider.setPlaylist(widget.songlist.songs);
                      // إذا كانت الأغنية الحالية هي نفسها الأغنية التي نقر عليها، نكمل تشغيلها من نفس المكان
                      print(
                          "musicProvider.currentSongId == widget.songlist.songs[index].id ${musicProvider.currentSongId == widget.songlist.songs[index].id}  ${musicProvider.currentSongId} ${widget.songlist.songs[index].id}");

                      if (musicProvider.currentSongId ==
                          widget.songlist.songs[index].id) {
                        if (musicProvider.isPlaying) {
                          printError(info: "is playing");
                        } else {
                          printError(info: "resume");
                          musicProvider.resumeSong();
                        } // لا نقوم بإعادة تشغيل الأغنية إذا كانت بالفعل قيد التشغيل
                      } else {
                        musicProvider.currentIndex =
                            index; // تحديث مؤشر الأغنية
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
