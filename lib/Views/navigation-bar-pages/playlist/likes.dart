// import 'package:flutter/material.dart';
// import 'package:music_app/CustomWidgets/custom-scaffold.dart';

// class Likes extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       title: 'Liked Songs',
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               '30 songs',
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.edit,
//                     color: const Color.fromARGB(255, 111, 8, 8)),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.shuffle,
//                     color: const Color.fromARGB(255, 97, 10, 10)),
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   backgroundColor: Color.fromARGB(255, 79, 10, 10),
//                 ),
//                 child: Icon(Icons.play_arrow, color: Colors.white),
//               ),
//             ],
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildSongTile(
//                   context,
//                   title: 'My Own Prison',
//                   artist: 'Creed',
//                   hasLyrics: true,
//                 ),
//                 _buildSongTile(
//                   context,
//                   title: 'squabble up',
//                   artist: 'Kendrick Lamar',
//                   hasLyrics: true,
//                   explicit: true,
//                 ),
//                 _buildSongTile(
//                   context,
//                   title: 'Crushed Velvet',
//                   artist: 'Molly Lewis, Thee Sacred Souls',
//                 ),
//                 _buildSongTile(
//                   context,
//                   title: 'Sacrilege',
//                   artist: 'Yeah Yeah Yeahs',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSongTile(
//     BuildContext context, {
//     required String title,
//     required String artist,
//     bool hasLyrics = false,
//     bool explicit = false,
//   }) {
//     return ListTile(
//       leading: Container(
//         width: 50,
//         height: 50,
//         color: Colors.grey[800],
//       ),
//       title: Text(
//         title,
//         style: TextStyle(color: Colors.white),
//       ),
//       subtitle: Row(
//         children: [
//           if (hasLyrics)
//             if (explicit)
//               Text(
//                 artist,
//                 style: TextStyle(color: Colors.white70),
//               ),
//         ],
//       ),
//       trailing: PopupMenuButton<String>(
//         icon: Icon(Icons.more_vert, color: Colors.white),
//         color: Colors.grey[900],
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         onSelected: (value) {
//           // Handle menu item selection
//           switch (value) {
//             case 'Add to other playlist':
//               // Add your action here
//               break;
//             case 'Remove from this playlist':
//               // Add your action here
//               break;
//             case 'Add to queue':
//               // Add your action here
//               break;
//             case 'View album':
//               // Add your action here
//               break;
//             case 'View artist':
//               // Add your action here
//               break;
//             case 'Share':
//               // Add your action here
//               break;
//           }
//         },
//         itemBuilder: (context) => [
//           PopupMenuItem(
//             value: 'Add to other playlist',
//             child: Text('Add to other playlist',
//                 style: TextStyle(color: Colors.white)),
//           ),
//           PopupMenuItem(
//             value: 'Remove from this playlist',
//             child: Text('Remove from this playlist',
//                 style: TextStyle(color: Colors.white)),
//           ),
//           PopupMenuItem(
//             value: 'Add to queue',
//             child: Text('Add to queue', style: TextStyle(color: Colors.white)),
//           ),
//           PopupMenuItem(
//             value: 'View album',
//             child: Text('View album', style: TextStyle(color: Colors.white)),
//           ),
//           PopupMenuItem(
//             value: 'View artist',
//             child: Text('View artist', style: TextStyle(color: Colors.white)),
//           ),
//           PopupMenuItem(
//             value: 'Share',
//             child: Text('Share', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSortOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.grey[900],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Sort by',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               _buildSortOption(context, 'Title'),
//               _buildSortOption(context, 'Artist'),
//               _buildSortOption(context, 'Album'),
//               _buildSortOption(context, 'Recently added', isSelected: true),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSortOption(BuildContext context, String title,
//       {bool isSelected = false}) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       title: Text(
//         title,
//         style: TextStyle(
//           color: isSelected ? Colors.white : Colors.white70,
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//       trailing: isSelected
//           ? Icon(Icons.check, color: Color.fromARGB(255, 93, 15, 8))
//           : null,
//       onTap: () {
//         Navigator.pop(context);
//         // Add your sorting logic here
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class Likes extends StatelessWidget {
  final UserViewModel userViewModel = Get.find<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    String token = LocalStorageService().getToken() ??
        ""; // استبدل هذا التوكن بتوكن المستخدم الفعلي

    userViewModel.fetchLikedSongs(token);

    return CustomScaffold(
      title: 'Liked Songs',
      body: Obx(() {
        if (userViewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (userViewModel.likedSongs.isEmpty) {
          return Center(child: Text('No liked songs found.'));
        } else {
          return ListView.builder(
            itemCount: userViewModel.likedSongsList.length,
            itemBuilder: (context, index) {
              final song = userViewModel.likedSongsList[index];
              return InkWell(
                onTap: () {
                  // تعيين قائمة الأغاني في البروفايدر
                  musicProvider.setPlaylist(userViewModel.likedSongsList);
                  // إذا كانت الأغنية الحالية هي نفسها الأغنية التي نقر عليها، نكمل تشغيلها من نفس المكان
                  if (musicProvider.currentSongId ==
                      userViewModel.likedSongsList[index].id) {
                    if (musicProvider.isPlaying) {
                      printError(info: "is playing");
                    } else {
                      printError(info: "resume");
                      musicProvider.resumeSong();
                    } // لا نقوم بإعادة تشغيل الأغنية إذا كانت بالفعل قيد التشغيل
                  } else {
                    musicProvider.currentIndex = index; // تحديث مؤشر الأغنية
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
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      // صورة البلاي ليست
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          song!.img,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flex(direction: Axis.vertical, children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.title,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              song.artist.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ]),
                      Spacer(),
                      IconButton(
                        icon: Icon(
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
    );
  }
}
