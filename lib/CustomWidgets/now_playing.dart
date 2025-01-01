import 'package:flutter/material.dart';
// استيراد MusicProvider
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MusicProvider musicProvider = Provider.of<MusicProvider>(
      context,
    );
    return musicProvider.currentSongTitle != null
        ? GestureDetector(
            onVerticalDragEnd: (details) {
              // عندما ينتهي السحب
              if (details.velocity.pixelsPerSecond.dy < 0) {
                if (!musicProvider.isPlaying) {
                  musicProvider.resumeSong();
                }
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return const MusicPlayer(); // صفحة الـ MusicPlayer
                  },
                );
                print("المستخدم أكمل السحب للأعلى");
              }
            },
            onTap: () {
              if (!musicProvider.isPlaying) {
                musicProvider.resumeSong();
              }
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const MusicPlayer(); // صفحة الـ MusicPlayer
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
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
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          musicProvider.currentSongTitle!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          musicProvider.currentSongArtistName!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // أزرار التشغيل والتوقف والنقل بين الأغاني
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous,
                            color: Colors.white),
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
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: musicProvider.skipNext,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const SizedBox(
            height: 0,
          );
  }
}
