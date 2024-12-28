import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:provider/provider.dart';

class MusicPlayer extends StatefulWidget {
  // final Song song;
  const MusicPlayer({
    super.key,
  });

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return CustomScaffold(
      // backgroundColor: Colors.greenAccent.shade100, // Background color
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        // width: 300, // Adjust the width to match your design
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 100),
            // Album Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.grey,
                height: MediaQuery.sizeOf(context).width * 0.75,
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: Center(
                  child: Image.network(musicProvider.currentSongImg!,
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Spacer(),

            // Song Info
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              // color: Colors.amber,

              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    musicProvider.currentSongTitle!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    musicProvider.currentSongArtist!,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Progress Bar
            Column(
              children: [
                Slider(
                  value: musicProvider.currentPosition.inSeconds
                      .toDouble(), // Current progress
                  max: musicProvider.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    musicProvider.seekTo(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(musicProvider.currentPosition),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _formatDuration(musicProvider.totalDuration),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.favorite_border, color: Colors.grey, size: 34),
                InkWell(
                  child:
                      Icon(Icons.skip_previous, color: Colors.white, size: 42),
                  onTap: musicProvider.currentIndex > 0
                      ? musicProvider.skipPrevious
                      : null,
                ),
                InkWell(
                  onTap: () {
                    if (musicProvider.isPlaying) {
                      musicProvider.pauseSong();
                    } else {
                      musicProvider.resumeSong();
                    }
                  },
                  child: Icon(
                      musicProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 58),
                ),
                InkWell(
                  child: Icon(Icons.skip_next, color: Colors.white, size: 42),
                  onTap: musicProvider.currentIndex <
                          musicProvider.playlist.length - 1
                      ? musicProvider.skipNext
                      : null,
                ),
                Icon(Icons.repeat, color: Colors.grey, size: 34),
              ],
            ),
            Spacer(),

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
