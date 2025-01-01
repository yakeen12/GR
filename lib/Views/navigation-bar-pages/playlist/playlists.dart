import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/gift.dart';
import 'package:music_app/Views/navigation-bar-pages/me/meeye.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/createplaylist.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/likes.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/myplaylistinside.dart';
import 'package:music_app/utils/local_storage_service.dart';

class PlayLists extends StatelessWidget {
  const PlayLists({super.key});

  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Search in your playlists...',
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
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
                const SizedBox(width: 22),
                InkWell(
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.amberAccent,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Meeye()));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 19,
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
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
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
              } else if (playlistViewModel.errorMessage.isNotEmpty) {
                return Text(
                  '${playlistViewModel.errorMessage}',
                  style: TextStyle(color: Colors.white),
                );
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
class PodcastTab extends StatelessWidget {
  const PodcastTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Center(
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
                      'https://yt3.googleusercontent.com/ytc/AIdro_knm8C6-aj25mYqJ01I6WoeJY1ctxQeswGLqO6xxV-ltA=s900-c-k-c0x00ffffff-no-rj', // Replace with your image URL
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '321B-Viking Legends: The Peacemaker',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Myths and Legends',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'On his quest to help princess Ingigerd, Hrolf has become enslaved by the wily Wi...',
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              // Progress bar and time left
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.5, // Example progress value
                      backgroundColor: Colors.grey[800],
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '53min left',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Save and more options
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ));
      },
    );
  }
}
