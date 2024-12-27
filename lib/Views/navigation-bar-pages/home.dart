import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/gift.dart';
import 'package:music_app/Views/navigation-bar-pages/me/me.dart';
import 'package:music_app/Views/navigation-bar-pages/me/meeye.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          // Music Room Tabs
          SizedBox(
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
                image: NetworkImage('https://via.placeholder.com/600x300'),
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
          _buildSectionHeader('Most Top Song', () {}),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildSongCard(
                    'Laugh', 'Goose House', 'https://via.placeholder.com/100'),
                _buildSongCard('Nancy Mulligan', 'Ed Sheeran',
                    'https://via.placeholder.com/100'),
                _buildSongCard(
                    'Up&Up', 'Coldplay', 'https://via.placeholder.com/100'),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Recent Added Group Section
          _buildSectionHeader('Recent Added Group', () {}),
          SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildGroupCard(
                    'Bunkface', 'Rock', 'https://via.placeholder.com/100'),
                _buildGroupCard('Barasuara', 'Alternative',
                    'https://via.placeholder.com/100'),
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

  Widget _buildSongCard(String title, String artist, String imageUrl) {
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
            title,
            style: TextStyle(color: Colors.white, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            artist,
            style: TextStyle(color: Colors.grey, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
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
