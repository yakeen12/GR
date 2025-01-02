import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/likeButton.dart';
import 'package:music_app/CustomWidgets/select-playList.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/players/music/artist.dart';
import 'package:music_app/Views/players/podcast/podcastPage.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class PodcastPlayer extends StatefulWidget {
  // final Song song;
  const PodcastPlayer({
    super.key,
  });

  @override
  State<PodcastPlayer> createState() => _PodcastPlayerState();
}

class _PodcastPlayerState extends State<PodcastPlayer> {
  @override
  Widget build(BuildContext context) {
    final podcastProvider = Provider.of<PodcastProvider>(context);
    return CustomScaffold(
      showNowPlaying: false,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        // width: 300, // Adjust the width to match your design
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 100),
            // Album Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.grey,
                height: MediaQuery.sizeOf(context).width * 0.75,
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: Center(
                  child: Image.network(
                      podcastProvider.currentEpisode!.podcast.img,
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const Spacer(),

            // Song Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              // color: Colors.amber,

              width: MediaQuery.sizeOf(context).width,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.85,
                        height: 40,
                        child: Marquee(
                          startAfter: Duration(seconds: 2),
                          showFadingOnlyWhenScrolling: true,
                          blankSpace: 100,
                          text:
                              '${podcastProvider.currentEpisode!.episodeNumber}  ${podcastProvider.currentEpisode!.title}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PodcastPage(
                                    podcastID: podcastProvider
                                        .currentEpisode!.podcast.id),
                              ));
                        },
                        child: Text(
                          podcastProvider.currentEpisode!.podcast.title,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Progress Bar
            Column(
              children: [
                Slider(
                  value: podcastProvider.currentPosition.inSeconds
                      .toDouble(), // Current progress
                  max: podcastProvider.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    podcastProvider.seekTo(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(podcastProvider.currentPosition),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _formatDuration(podcastProvider.totalDuration),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 16),
            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text(
                    "1.0x",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  onTap: () {},
                ),
                InkWell(
                  onTap: () {
                    if (podcastProvider.currentPosition.inSeconds.toInt() >
                        30) {
                      podcastProvider.seekTo(Duration(
                          seconds: podcastProvider.currentPosition.inSeconds
                                  .toInt() -
                              30));
                    } else {
                      podcastProvider.seekTo(Duration(seconds: 0));
                    }
                  },
                  child: const Icon(Icons.replay_30,
                      color: Colors.white, size: 42),
                ),
                InkWell(
                  onTap: () {
                    if (podcastProvider.isPlaying) {
                      podcastProvider.pauseEpisode();
                    } else {
                      podcastProvider.resumeEpisode();
                    }
                  },
                  child: Icon(
                      podcastProvider.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 58),
                ),
                InkWell(
                  onTap: () {
                    if (podcastProvider.currentPosition.inSeconds.toInt() <
                        podcastProvider.totalDuration.inSeconds.toInt() - 30) {
                      podcastProvider.seekTo(Duration(
                          seconds: podcastProvider.currentPosition.inSeconds
                                  .toInt() +
                              30));
                    }
                  },
                  child: const Icon(Icons.forward_30_outlined,
                      color: Colors.white, size: 42),
                ),
                PopupMenuButton<String>(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // جعل الحواف مستديرة
                  ),
                  // child: Container(color: Colors.white),
                  iconSize: 36,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onSelected: (value) async {
                    if (value == 'Share Song') {
                      // مشاركة الأغنية
                      // shareSong(
                      //     song); // نفذ عملية المشاركة (يمكنك استخدام مكتبة مثل share_plus)
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'Share Song',
                      child: Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                            'Share Song',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),

            // Devices Available
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
