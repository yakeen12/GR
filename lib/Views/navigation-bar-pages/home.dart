import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/custom_song_card.dart';
import 'package:music_app/ViewModels/episode_view_model.dart';
import 'package:music_app/ViewModels/search_view_model.dart';
import 'package:music_app/ViewModels/songs_view_model.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/navigation-bar-pages/communities/post_inside.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/gift.dart';
import 'package:music_app/Views/navigation-bar-pages/me/me_outside_user_search.dart';
import 'package:music_app/Views/navigation-bar-pages/me/meeye.dart';
import 'package:music_app/Views/players/music/artist.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/Views/players/podcast/podcastPage.dart';
import 'package:music_app/Views/players/podcast/podcastPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SongViewModel songViewModel = Get.put(SongViewModel());
  final EpisodeViewModel episodeViewModel = Get.put(EpisodeViewModel());
  final SearchViewModel _searchViewModel = Get.put(SearchViewModel());
  final TextEditingController _searchController = TextEditingController();
  final UserViewModel userViewModel = Get.put(UserViewModel());

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);
    userViewModel.fetchUserProfile(LocalStorageService().getToken()!);

    songViewModel.getLatestSongs();
    episodeViewModel.getLatestepisodes();

    return CustomScaffold(
      body: Stack(
        children: [
          // الصفحة الرئيسية
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: [
                _buildFeaturedSection(),
                SizedBox(height: 20),
                _buildSectionHeader('Latest Songs', () {}),
                _buildLatestSongs(musicProvider, podcastProvider),
                SizedBox(height: 20),
                _buildSectionHeader('Latest Podcast Episodes', () {}),
                _buildLatestEpisodes(podcastProvider, musicProvider),
              ],
            ),
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
                  _searchViewModel.search(query);
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
              color: Colors.transparent, // اللون الشفاف للخلفية
            ),
          ),

          // صندوق النتائج الذي يظهر أعلى الصفحة
          Positioned(
            top: 110, // مكان صندوق النتائج أسفل مربع البحث
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
                    ///      -----------------  posts --------------------
                    if (_searchViewModel.posts.isNotEmpty)
                      Text(
                        "Posts",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.posts.map((post) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostPage(
                                        post: post,
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(44, 255, 255, 255),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(post.user.profilePicture!),
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    post.user.username,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                post.content,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
// --------------- end posts ------------------------------

                    //   ------------- songs --------------------------
                    if (_searchViewModel.songs.isNotEmpty)
                      Text(
                        "Songs",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.songs.map((song) {
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
                    // -----------------------   end songs -------------------------

                    // ------------------     podcasts -----------------

                    if (_searchViewModel.podcasts.isNotEmpty)
                      Text(
                        "Podcasts",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.podcasts.map((podcast) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PodcastPage(podcastID: podcast.id),
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
                                  podcast.img,
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
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width - 180,
                                    child: Text(
                                      podcast.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width - 180,
                                    child: Text(
                                      podcast.host!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

                    // -----------------    end podcasts   ----------------------

// -------------------------      episodes -------------------------------

                    if (_searchViewModel.episodes.isNotEmpty)
                      Text(
                        "Episodes",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.episodes.map((episode) {
                      return InkWell(
                        onTap: () {
                          musicProvider.stop();
                          podcastProvider.setEpisode(episode);
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
                                  episode.podcast.img,
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
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width - 180,
                                    child: Text(
                                      episode.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width - 180,
                                    child: Text(
                                      episode.podcast.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

// ----------------------- end episodes --------------------------------

// --------------------    artists   ------------------
                    if (_searchViewModel.artists.isNotEmpty)
                      Text(
                        "Artists",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.artists.map((artist) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArtistPage(artistID: artist.id),
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
                                  artist.image!,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 180,
                                child: Text(
                                  artist.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

// -------------------       end artists      -------------------

// ----------------------         users -----------------------------

                    if (_searchViewModel.users.isNotEmpty)
                      Text(
                        "Users",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),

                    ..._searchViewModel.users.map((user) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeOutSide(user: user),
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
                                  user.profilePicture!,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width - 180,
                                child: Text(
                                  user.username,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

// ------------------------------      end users ------------------------------
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildFeaturedSection() {
    return Container(
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
    );
  }

  Widget _buildLatestSongs(
      MusicProvider musicProvider, PodcastProvider podcastProvider) {
    return SizedBox(
      height: 200,
      child: Obx(() {
        if (songViewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (!songViewModel.hasSongs) {
          return Center(child: Text("No songs available."));
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
                  title: songs[index].title,
                ),
              );
            },
          );
        }
      }),
    );
  }

  Widget _buildLatestEpisodes(
      PodcastProvider podcastProvider, MusicProvider musicProvider) {
    return SizedBox(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
        }));
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
