import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Providers/music_provider.dart'; // استيراد MusicProvider
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatelessWidget {
  final musicProvider;
  const NowPlaying({
    required this.musicProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return musicProvider.currentSongTitle != null
        ? InkWell(
            onTap: () {
              if (!musicProvider.isPlaying) {
                musicProvider.resumeSong();
              }
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return MusicPlayer(); // صفحة الـ MusicPlayer
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.black, // لون خلفية الميني بلاير
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Colors.white,
                    ),
                    child: Image.network(musicProvider.currentSongImg!,
                        fit: BoxFit.cover),
                  ),
                  // اسم الأغنية واسم الفنان
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          musicProvider.currentSongTitle!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          musicProvider.currentSongArtist!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // أزرار التشغيل والتوقف والنقل بين الأغاني
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous, color: Colors.white),
                        onPressed: musicProvider.skipPrevious,
                      ),
                      IconButton(
                        icon: Icon(
                          musicProvider.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          if (musicProvider.isPlaying) {
                            musicProvider.pauseSong();
                          } else {
                            musicProvider.resumeSong();
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next, color: Colors.white),
                        onPressed: musicProvider.skipNext,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: 0,
          );
  }
}
