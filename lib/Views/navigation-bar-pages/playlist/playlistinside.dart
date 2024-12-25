import 'package:flutter/material.dart';

class Playlistinside extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Playlist Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/eminem_album.jpg', // Replace with your album image
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3 songs • 14min 44sec',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            // Buttons and Options
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text('SHUFFLE'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('EDIT', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),

            SizedBox(height: 16),

            Row(
              children: [
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.purple,
                ),
                Text(
                  'Downloaded',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Filters and AI Mix
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Filter'),
                  _buildFilterChip('International'),
                  _buildFilterChip('Pop Rap'),
                  _buildFilterChip('Gangsta Rap'),
                ],
              ),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text('AI MIX this playlist'),
            ),

            SizedBox(height: 16),

            // Song List
            Expanded(
              child: ListView(
                children: [
                  _buildSongTile('When I\'m Gone', 'assets/when_im_gone.jpg'),
                  _buildSongTile(
                      'Sing For The Moment', 'assets/sing_for_the_moment.jpg'),
                  _buildSongTile('Love The Way You Lie',
                      'assets/love_the_way_you_lie.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.grey[800],
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSongTile(String title, String imagePath) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Eminem',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: Icon(Icons.more_vert, color: Colors.white),
    );
  }
}
