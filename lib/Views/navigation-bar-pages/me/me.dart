import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/post_widget.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/ViewModels/post_view_model.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/myplaylistinside.dart';
import 'package:music_app/utils/local_storage_service.dart';

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  final UserViewModel userViewModel = Get.put(UserViewModel());
  final PlaylistViewModel playlistViewModel = Get.put(PlaylistViewModel());
  final PostViewModel postViewModel = PostViewModel();

  @override
  Widget build(BuildContext context) {
    final token = LocalStorageService().getToken();
    print(token);
    userViewModel.fetchUserProfile(token!);
    playlistViewModel.fetchUserPlaylists(token);
    if (userViewModel.user.value != null)
      postViewModel.getPostsByUserId(userViewModel.user.value!.id);

    return CustomScaffold(body: SingleChildScrollView(child: Obx(() {
      if (userViewModel.isLoading.value) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                CircularProgressIndicator(),
                Spacer(),
              ]),
        ); // عرض مؤشر التحميل
        // } else if (userViewModel.errorMessage.isNotEmpty) {
        //   return Center(
        //       child: Text(
        //     userViewModel.errorMessage.value,
        //     style: TextStyle(color: Colors.white),
        //   )); // عرض رسالة خطأ
      } else {
        var user = userViewModel.user.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user!.profilePicture!), //
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              user.username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _buildSectionHeader("PlayLists:", () {}),
            SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 140,
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
                        scrollDirection: Axis.horizontal,
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
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(25, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.only(
                                left: 15,
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(
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
                                  const SizedBox(height: 10),
                                  Text(
                                    playlist.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                })),
            SizedBox(
              height: 50,
            ),
            _buildSectionHeader("Posts:", () {}),
            SizedBox(
              height: 15,
            ),
            Obx(() {
              if (postViewModel.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (postViewModel.errorMessage.isNotEmpty) {
                return Text(
                  '${playlistViewModel.errorMessage}',
                  style: TextStyle(color: Colors.white),
                );
              } else if (postViewModel.posts.value == null ||
                  postViewModel.posts.value!.isEmpty) {
                return const Center(
                    child: Text(
                  'You did not post anything yet :)',
                  style: TextStyle(color: Colors.white),
                ));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ...List.generate(
                          postViewModel.posts.value!.length,
                          (index) => PostWidget(
                              post: postViewModel.posts.value![index]))
                    ],
                  ),
                );
              }
            })
          ],
        );
      }
    })));
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
