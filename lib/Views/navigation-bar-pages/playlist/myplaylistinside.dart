import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/artist.dart';

class MyPlaylistinside extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Play list name',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.add_outlined,
                    color: Color.fromARGB(255, 100, 28, 11)),
                SizedBox(width: 14),
                Icon(Icons.edit, color: Color.fromARGB(255, 114, 12, 12)),
                SizedBox(width: 14),
                Icon(Icons.shuffle, color: Color.fromARGB(255, 114, 12, 12)),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.play_circle_fill,
                      color: Color.fromARGB(255, 94, 17, 13), size: 48),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  PlaylistItem(
                    title: 'Lovesong',
                    subtitle: 'The Cure',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  PlaylistItem(
                    title: 'This Light Between Us',
                    subtitle: 'Armin van Buuren',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  // final VoidCallback onTap; // Add onTap callback

  PlaylistItem(
      {required this.title,
      // required this.onTap,
      required this.subtitle,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ListTile(
                          leading:
                              Icon(Icons.playlist_add, color: Colors.white),
                          title: Text('Add to other playlist',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.remove_circle_outline,
                              color: Colors.white),
                          title: Text('Remove from this playlist',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.album, color: Colors.white),
                          title: Text('Post',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.white),
                          title: Text('View artist',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Artist()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.share, color: Colors.white),
                          title: Text('Share',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
