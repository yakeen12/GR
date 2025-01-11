import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/ViewModels/episode_view_model.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/ViewModels/search_view_model.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/gift.dart';
import 'package:music_app/Views/navigation-bar-pages/me/meeye.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/music/createplaylist.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/music/likes.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/myplaylistinside.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/Views/players/podcast/podcastPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class PlayLists extends StatefulWidget {
  const PlayLists({super.key});

  @override
  State<PlayLists> createState() => _PlayListsState();
}

class _PlayListsState extends State<PlayLists> {
  final SearchViewModel _searchViewModel = Get.put(SearchViewModel());
  final TextEditingController _searchController = TextEditingController();
  final UserViewModel userViewModel = Get.put(UserViewModel());
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      // TabBar داخل الـ Scaffold
                      TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        tabs: [
                          Tab(
                            child: Container(
                              height: 35,
                              alignment: Alignment.center,
                              child: const Text(
                                'Music',
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 35,
                              alignment: Alignment.center,
                              child: const Text(
                                'Podcast',
                              ),
                            ),
                          ),
                        ],
                      ),
                      // TabBarView يحتاج إلى أن يشغل المساحة المتبقية بالكامل
                      Expanded(
                        child: TabBarView(
                          children: [
                            PlaylistsTab(),
                            PodcastTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // مربع البحث
          _buildSearchField(),

          Obx(() {
            if (_searchViewModel.hasResults)
              return _buildSearchPanel();
            else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  _searchViewModel.searchInPlayLists(query);
                } else {}
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            child: const SizedBox(
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
                  MaterialPageRoute(builder: (context) => const Gift()));
            },
          ),
          const SizedBox(width: 15),
          Obx(() {
            if (userViewModel.user.value != null)
              return InkWell(
                child: SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      userViewModel.user.value!.profilePicture!,
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Meeye()));
                },
              );
            else {
              return SizedBox(
                height: 30,
                width: 35,
              );
            }
          })
        ],
      ),
    );
  }

  Widget _buildSearchPanel() {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);
    return Obx(() {
      if (!_searchViewModel.hasResults)
        return SizedBox.shrink(); // إذا لم يكن هناك نتائج، لا نعرض شيء

      return Stack(
        children: [
          // الخلفية الشفافة التي تغطي الشاشة
          GestureDetector(
            onTap: () {
              _searchViewModel
                  .clearResults(); // إخفاء النتائج عند النقر خارج الصندوق
              FocusScope.of(context).unfocus(); // إخفاء لوحة المفاتيح
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),

          Positioned(
            top: 110,
            left: 12,
            right: 12,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              color: Color.fromARGB(185, 0, 0, 0),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 300,
                ),
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: [
                    //   ------------- like --------------------------
                    if (_searchViewModel.likedSongs.isNotEmpty)
                      Text(
                        "Likes",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.likedSongs.map((song) {
                      return InkWell(
                        onTap: () {
                          podcastProvider.stop();

                          musicProvider.setPlaylistAndSong(
                            [song], // البلاي ليست الحالية
                            0, // الـ Index للأغنية
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
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(44, 255, 255, 255),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  song.img,
                                  fit: BoxFit.cover,
                                  height: 50,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    song.artist.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    // -----------------------   end likes -------------------------

                    //   ------------- playLists songs --------------------------
                    if (_searchViewModel.playlistSongs.isNotEmpty)
                      Text(
                        "Songs in your playLists",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.playlistSongs.map((song) {
                      return InkWell(
                        onTap: () {
                          podcastProvider.stop();

                          musicProvider.setPlaylistAndSong(
                            [song], // البلاي ليست الحالية
                            0, // الـ Index للأغنية
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
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(44, 255, 255, 255),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  song.img,
                                  fit: BoxFit.cover,
                                  height: 50,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    song.artist.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    // -----------------------   end playLists -------------------------

                    //   ------------- playLists --------------------------
                    if (_searchViewModel.playLists.isNotEmpty)
                      Text(
                        "Your PlayLists",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.playLists.map((playList) {
                      return InkWell(
                        onTap: () {
                          // open playList inside
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MyPlaylistinside(songlist: playList),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(44, 255, 255, 255),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  (playList.songs.isNotEmpty)
                                      ? playList.songs.first.img
                                      : "https://www.tuaw.com/wp-content/uploads/2024/08/Apple-Music.jpg",
                                  fit: BoxFit.cover,
                                  height: 50,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                playList.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    // -----------------------   end playLists -------------------------
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class PlaylistsTab extends StatelessWidget {
  final PlaylistViewModel playlistViewModel = Get.put(PlaylistViewModel());
  final token = LocalStorageService().getToken();

  PlaylistsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    playlistViewModel.fetchUserPlaylists(token!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Likes()));
                },
                child: Container(
                  height: 80,
                  width: MediaQuery.sizeOf(context).width * 0.47,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 172, 18, 7),
                          ),
                          Text(
                            "Likes",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePlaylist()));
                },
                borderRadius: BorderRadius.circular(
                    15), // Matches Container's border radius
                child: Container(
                  height: 80,
                  width: MediaQuery.sizeOf(context).width * 0.47,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 158, 158, 158),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: const Center(
                    child: Text(
                      "+ NEW PLAYLIST",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(child: SizedBox(
            // height: MediaQuery.sizeOf(context).height * 0.3,
            child: Obx(() {
              if (playlistViewModel.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
                // } else if (playlistViewModel.errorMessage.isNotEmpty) {
                //   return Text(
                //     '${playlistViewModel.errorMessage}',
                //     style: TextStyle(color: Colors.white),
                //   );
              } else if (playlistViewModel.playlists.isEmpty) {
                return const Center(
                    child: Text(
                  'You did not make any playList yet :)',
                  style: TextStyle(color: Colors.white),
                ));
              } else {
                return ListView.builder(
                  itemCount: playlistViewModel.playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlistViewModel.playlists[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MyPlaylistinside(songlist: playlist),
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            // صورة البلاي ليست
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                (playlist.songs.isNotEmpty)
                                    ? playlist.songs.first.img
                                    : "https://www.tuaw.com/wp-content/uploads/2024/08/Apple-Music.jpg",
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flex(direction: Axis.vertical, children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    playlist.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${playlist.songs.length} songs",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          )),
        ],
      ),
    );
  }
}

// محتوى تبويب البودكاست
class PodcastTab extends StatefulWidget {
  const PodcastTab({super.key});

  @override
  State<PodcastTab> createState() => _PodcastTabState();
}

class _PodcastTabState extends State<PodcastTab> {
  @override
  Widget build(BuildContext context) {
    PodcastProvider podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);

    EpisodeViewModel episodeViewModel = EpisodeViewModel();
    episodeViewModel.getAllEpisodes();

    return Obx(() {
      if (episodeViewModel.isLoading.value) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )); // تحميل
      } else if (episodeViewModel.errorMessage.isNotEmpty) {
        return Center(
            child: Text(
          episodeViewModel.errorMessage.value,
          style: TextStyle(color: Colors.white),
        )); // خطأ
      } else if (!episodeViewModel.hasEpisodes) {
        return Center(child: Text("No Episodes available.")); // فارغة
      } else {
        var episodes = episodeViewModel.episodes.value;
        return ListView.builder(
          itemCount: episodes!.length,
          itemBuilder: (context, index) {
            var episode = episodes[index];
            MusicProvider musicProvider =
                Provider.of<MusicProvider>(context, listen: false);
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
              child: Center(
                  child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(69, 158, 158, 158),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with title and subtitle
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            episode.podcast.img,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${episode.episodeNumber} ${episode.title}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                episode.podcast.title,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Description
                    Text(
                      episode.description,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),

                    // Save and more options
                  ],
                ),
              )),
            );
          },
        );
      }
    });
  }
}
