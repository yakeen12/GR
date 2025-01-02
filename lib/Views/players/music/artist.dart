import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/customSongCard.dart';
import 'package:music_app/Models/artist_model.dart';
import 'package:music_app/ViewModels/artist_view_model.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:provider/provider.dart';

class ArtistPage extends StatefulWidget {
  final String artistID;

  const ArtistPage({super.key, required this.artistID});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  final ArtistsViewModel artistsViewModel = ArtistsViewModel();

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    artistsViewModel.fetchArtistProfile(widget.artistID);
    return CustomScaffold(
      title: '',
      body: Obx(() {
        if (artistsViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (artistsViewModel.errorMessage.isNotEmpty) {
          return Text(
            '${artistsViewModel.errorMessage}',
            style: TextStyle(color: Colors.white),
          );
        } else {
          var artist = artistsViewModel.artist.value!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150, // Set the width of the container
                      height: 150, // Set the height of the container
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.black54),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              artist.image!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      artist.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              'Follow',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.more_vert, color: Colors.white),
                        const Spacer(),
                        const Icon(Icons.shuffle, color: Colors.white),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor:
                                const Color.fromARGB(255, 81, 6, 6),
                          ),
                          child:
                              const Icon(Icons.play_arrow, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: artist.songs!.length,
                    itemBuilder: (context, index) {
                      return CustomSongCardPlayList(
                          song: artist.songs![index],
                          onTap: () {
                           
                            musicProvider.setPlaylistAndSong(
                              artist.songs!, // البلاي ليست الحالية
                              index, // الـ Index للأغنية
                            );
                            // استدعاء MusicPlayer كـ BottomSheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return const MusicPlayer(); // صفحة الـ MusicPlayer
                              },
                            );
                          });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }
      }),
    );
  }
}
