import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/custom_song_card.dart';
import 'package:music_app/ViewModels/episode_view_model.dart';
import 'package:music_app/ViewModels/songs_view_model.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/gift.dart';
import 'package:music_app/Views/navigation-bar-pages/me/meeye.dart';
import 'package:music_app/Views/players/podcast/podcastPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final SongViewModel songViewModel = Get.put(SongViewModel());
  final EpisodeViewModel episodeViewModel = Get.put(EpisodeViewModel());

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);

    songViewModel.getLatestSongs();
    episodeViewModel.getLatestepisodes();

    return CustomScaffold(
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          // Music Room Tabs
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    enabled: false,
                    onTap: () {},
                    style: TextStyle(color: Colors.black),
                    // onChanged: _filterItems,
                    decoration: InputDecoration(
                      labelText:
                          'Search in your playlists...', // Use confirmation text as label if provided, else use default label text
                      labelStyle:
                          TextStyle(color: Colors.black), // Set accent color

                      prefixIcon: Icon(Icons.search),

                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.card_giftcard_outlined,
                      color: Colors.white,
                      size: 33.2,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Gift()));
                  },
                ),
                SizedBox(
                  width: 20,
                ), //
                InkWell(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.amberAccent,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Meeye()));
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 19,
          ),
          SizedBox(height: 20),

          // Featured Section
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.unc.edu/wp-content/uploads/2023/07/summer.playlist.hero_.shutterstock-scaled-e1660067871311.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'SUMMER CHILL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 20),

          // Most Top Song Section
          _buildSectionHeader('Latest Songs', () {}),
          SizedBox(height: 10),
          SizedBox(
              height: 200,
              child: Obx(() {
                if (songViewModel.isLoading.value) {
                  return Center(child: CircularProgressIndicator()); // تحميل
                } else if (songViewModel.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text(
                    songViewModel.errorMessage.value,
                    style: TextStyle(color: Colors.blue),
                  )); // خطأ
                } else if (!songViewModel.hasSongs) {
                  return Center(child: Text("No songs available.")); // فارغة
                } else {
                  var songs = songViewModel.songs.value;
                  return ListView.builder(
                      itemCount: songs!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            podcastProvider.stop();
                            
                            musicProvider.setPlaylistAndSong(
                              songs, // البلاي ليست الحالية
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
                          child: CustomSongCard(
                              artist: songs[index].artist.name,
                              imageUrl: songs[index].img,
                              title: songs[index].title),
                        ); // استدعاء العنصر حسب الفهرس
                      });
                  // ,
                }
              })),

          SizedBox(height: 20),

          // Recent Added Group Section
          _buildSectionHeader('Latest Podcast Episodes', () {}),
          SizedBox(height: 10),
          SizedBox(
              height: 360,
              child: Obx(() {
                if (episodeViewModel.isLoading.value) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )); // تحميل
                }
                // else if (episodeViewModel.errorMessage.isNotEmpty) {
                //   return Center(
                //       child: Text(
                //     episodeViewModel.errorMessage.value,
                //     style: TextStyle(color: Colors.white),
                //   )); // خطأ
                // }
                else if (!episodeViewModel.hasEpisodes) {
                  return Center(child: Text("No Episodes available.")); // فارغة
                } else {
                  var episodes = episodeViewModel.episodes.value;
                  return ListView.builder(
                      itemCount: episodes!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var episode = episodes[index];
                        return InkWell(
                            onTap: () {
                              musicProvider.stop();
                              podcastProvider.setEpisode(
                                episode,
                              );
                              // استدعاء PodcastPlayer كـ BottomSheet
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return PodcastPlayer(); // صفحة الـ MusicPlayer
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 250,
                              height: 360,
                              decoration: BoxDecoration(
                                color: Color(0xFF1C1C1C),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: Image.network(
                                      episode.podcast.img,
                                      fit: BoxFit.cover,
                                      height: 130,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      height: 180,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${episode.episodeNumber}  ${episode.title}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            episode.description,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[400],
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Spacer(),
                                          Text(
                                            episode.podcast.title,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )); // استدعاء العنصر حسب الفهرس
                      });
                  // ,
                }
              })),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, bool isSelected) {
    return Text(
      title,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.grey,
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAllPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onViewAllPressed,
          child: Text('See All', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _buildGroupCard(String name, String genre, String imageUrl) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, height: 70, fit: BoxFit.cover),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            genre,
            style: TextStyle(color: Colors.grey, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
