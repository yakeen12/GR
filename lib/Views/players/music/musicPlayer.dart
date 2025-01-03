import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/likeButton.dart';
import 'package:music_app/CustomWidgets/select-playList.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/navigation-bar-pages/communities/create_post.dart';
import 'package:music_app/Views/players/music/artist.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
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
  final UserViewModel userViewModel = Get.find<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(
      context,
    );
    // bool isLiked = userViewModel.likedSongs
    //     .any((likedSong) => likedSong?.id == musicProvider.currentSongId);
    return CustomScaffold(
      showNowPlaying: false,
      // backgroundColor: Colors.greenAccent.shade100, // Background color
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
                  child: Image.network(musicProvider.currentSongImg!,
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
                      Text(
                        musicProvider.currentSongTitle!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtistPage(
                                    artistID:
                                        musicProvider.currentSongArtist!.id),
                              ));
                        },
                        child: Text(
                          musicProvider.currentSongArtistName!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
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
                      } else if (value == 'Add to Playlist') {
                        final selectedPlaylistId = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return PlaylistSelectionDialog(
                              songId: musicProvider.currentSongId!,
                            );
                          },
                        );

                        Navigator.of(context)
                            .pop(); // اغلق الحوار وعد للميوزيك بلاير
                      } else if (value == "Post to Community") {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePostPage(
                                  song: musicProvider.currentSong!),
                            ));
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
                      PopupMenuItem(
                        value: 'Add to Playlist',
                        child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.all(15),
                            child: const Text(
                              'Add Song to Playlist',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      PopupMenuItem(
                        value: 'Post to Community',
                        child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.all(15),
                            child: const Text(
                              'Post to Community',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
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
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _formatDuration(musicProvider.totalDuration),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LikeButton(
                    songId: musicProvider.currentSongId!,
                    userViewModel: userViewModel,
                    token: LocalStorageService().getToken()!),
                InkWell(
                  onTap: musicProvider.currentIndex > 0
                      ? musicProvider.skipPrevious
                      : null,
                  child: const Icon(Icons.skip_previous,
                      color: Colors.white, size: 42),
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
                  onTap: musicProvider.currentIndex <
                          musicProvider.playlist.length - 1
                      ? musicProvider.skipNext
                      : null,
                  child: const Icon(Icons.skip_next,
                      color: Colors.white, size: 42),
                ),
                InkWell(
                  child: Icon(
                      musicProvider.isRepeat ? Icons.repeat_on : Icons.repeat,
                      color:
                          musicProvider.isRepeat ? Colors.white : Colors.grey,
                      size: 34),
                  onTap: () {
                    musicProvider.toggleRepeat();
                  },
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
