import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/custom_song_card.dart';
import 'package:music_app/ViewModels/songs_view_model.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/gift.dart';
import 'package:music_app/Views/navigation-bar-pages/me/me.dart';
import 'package:music_app/Views/navigation-bar-pages/me/meeye.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final SongViewModel songViewModel = Get.put(SongViewModel());

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    songViewModel.getLatestSongs();

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
                            // تعيين قائمة الأغاني في البروفايدر

                            musicProvider.setPlaylist(songs);

                            // إذا كانت الأغنية الحالية هي نفسها الأغنية التي نقر عليها، نكمل تشغيلها من نفس المكان
                            if (musicProvider.currentSongId ==
                                songs[index].id) {
                              if (musicProvider.isPlaying) {
                                printError(info: "is playing");
                              } else {
                                printError(info: "resume");
                                musicProvider.resumeSong();
                              } // لا نقوم بإعادة تشغيل الأغنية إذا كانت بالفعل قيد التشغيل
                            } else {
                              musicProvider.currentIndex =
                                  index; // تحديث مؤشر الأغنية
                              // تشغيل أول أغنية تلقائيًا

                              musicProvider.playSong();
                            }

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
          _buildSectionHeader('Recent Added Group', () {}),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildGroupCard('Bunkface', 'Rock',
                    'https://mrwallpaper.com/images/hd/summer-vibes-aesthetic-h515jny4z31mjulw.jpg'),
                _buildGroupCard('Barasuara', 'Alternative',
                    'https://mrwallpaper.com/images/hd/summer-vibes-aesthetic-h515jny4z31mjulw.jpg'),
              ],
            ),
          ),
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
