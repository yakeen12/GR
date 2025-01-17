import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/customSongCard.dart';
import 'package:music_app/Models/secretGift_model.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:provider/provider.dart';

class MyGiftInside extends StatefulWidget {
  final SecretGift secretGift;
  const MyGiftInside({
    super.key,
    required this.secretGift,
  });
  @override
  State<MyGiftInside> createState() => _MyGiftInsideState();
}

class _MyGiftInsideState extends State<MyGiftInside> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(
      context,
    );

    // musicProvider.setPlaylist(widget.songlist.songs);
    // musicProvider.setCurrentIndex(0);

    return CustomScaffold(
      title: "",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.shuffle,
                      color: Color.fromARGB(194, 255, 255, 255), size: 40),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: const Icon(Icons.play_circle_fill,
                      color: Color.fromARGB(194, 255, 255, 255), size: 48),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
                itemCount: widget.secretGift.songList.length,
                itemBuilder: (context, index) {
                  return CustomSongCardPlayList(
                    playListId: widget.secretGift.id,
                    song: widget.secretGift.songList[index],
                    onTap: () {
                      final podcastProvider =
                          Provider.of<PodcastProvider>(context, listen: false);

                      podcastProvider.stop();

                      musicProvider.setPlaylistAndSong(
                        widget.secretGift.songList,
                        index, // الـ Index للأغنية
                      );
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
