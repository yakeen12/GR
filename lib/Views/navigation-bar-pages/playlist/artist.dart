import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';

class Artist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: '',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/album_cover.jpg'), // Replace with your asset or network image
                  radius: 35,
                ),
                SizedBox(height: 16),
                Text(
                  'Kendrick Lamar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 16),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          'Follow',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.more_vert, color: Colors.white),
                    Spacer(),
                    Icon(Icons.shuffle, color: Colors.white),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Color.fromARGB(255, 81, 6, 6),
                      ),
                      child: Icon(Icons.play_arrow, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  tabs: [
                    Tab(text: 'Music'),
                    Tab(text: 'Events'),
                    Tab(text: 'Merch'),
                  ],
                ),
                SizedBox(
                  height: 400, // Adjust the height based on your content
                  child: TabBarView(
                    children: [
                      _buildMusicTab(),
                      Center(
                        child: Text(
                          'Events Coming Soon',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Merch Available',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildMusicTile(
          title: 'luther (with sza)',
          explicit: true,
        ),
        _buildMusicTile(
          title: 'tv off (feat. lefty gunplay)',
          explicit: true,
        ),
        _buildMusicTile(
          title: 'all the stars',
        ),
      ],
    );
  }

  Widget _buildMusicTile({
    required String title,
    bool explicit = false,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        color: Colors.grey[800],
        child: Icon(Icons.music_note, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Icon(Icons.more_vert, color: Colors.white),
    );
  }
}
