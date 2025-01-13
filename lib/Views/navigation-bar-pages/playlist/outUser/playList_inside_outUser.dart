import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/customSongCard.dart';
import 'package:music_app/Models/playList_model.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class OutUserPlaylistinside extends StatefulWidget {
  final Playlist songlist;
  const OutUserPlaylistinside({
    super.key,
    required this.songlist,
  });
  @override
  State<OutUserPlaylistinside> createState() => _OutUserPlaylistinsideState();
}

class _OutUserPlaylistinsideState extends State<OutUserPlaylistinside> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage:
                NetworkImage(widget.songlist.createdBy.profilePicture!), //
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.songlist.createdBy.username,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
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
                      final podcastProvider =
                          Provider.of<PodcastProvider>(context, listen: false);

                      podcastProvider.stop();

                      musicProvider.setPlaylistAndSong(
                        widget.songlist.songs,
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
