import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/song_model.dart';

class MusicPlayer extends StatefulWidget {
  final Song song;
  const MusicPlayer({super.key, required this.song});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isInitialized = false; // إضافة متغير لفحص إذا تم تحميل الصوت

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // الإعدادات الأولية
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        setState(() {
          isPlaying =
              false; // عند انتهاء الأغنية، نعيد حالة isPlaying إلى false
        });
      }
    });
  }

  void _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.song.url));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer
        .dispose(); // تأكد من التخلص من الـ AudioPlayer عند إغلاق الشاشة.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Image.network(widget.song.img, fit: BoxFit.cover),
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
                    widget.song.title,
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
                    widget.song.artist.name,
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
                  value: 0.3, // Current progress
                  onChanged: (value) {},
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0:34',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '2:27',
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
                Icon(Icons.skip_previous, color: Colors.white, size: 42),
                InkWell(
                  onTap: () {
                    _playPause();
                  },
                  child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white, size: 58),
                ),
                Icon(Icons.skip_next, color: Colors.white, size: 42),
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
}
