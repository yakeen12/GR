import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/Views/navigation-bar-pages/me/me.dart';

class PlayLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(children: [
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Me()));
                },
              ),
              SizedBox(
                width: 22,
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Me()));
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 19,
        ),
        Expanded(
          // height: MediaQuery.sizeOf(context).height * 0.8,
          child: DefaultTabController(
            length: 2,
            child: Flex(
                direction: Axis.vertical,
                // height: MediaQuery.sizeOf(context).height * 0.7,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        // TabBar داخل الـ Scaffold
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            insets: EdgeInsets.symmetric(horizontal: 30.0),
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: EdgeInsets.symmetric(horizontal: 20),
                          tabs: [
                            Tab(
                              child: Container(
                                height: 35,
                                alignment: Alignment.center,
                                child: Text(
                                  'Music',
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                height: 35,
                                alignment: Alignment.center,
                                child: Text(
                                  'Podcast',
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.7,
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
                ]),
          ),
        )
      ]),
    );
  }
}

class PlaylistsTab extends StatelessWidget {
  final List<Map<String, String>> playlists = [
    {
      'name': 'playlist1',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273ee0f38410382a255e4fb15f4',
      'songs': '25 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSja2eRhSlJnA_GwaOwAaaUDLj1SiZzJ5lXXg&s',
      'songs': '25 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://upload.wikimedia.org/wikipedia/ar/f/f6/Taylor_Swift_-_1989.png',
      'songs': '11 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273ee0f38410382a255e4fb15f4',
      'songs': '25 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://img.youm7.com/ArticleImgs/2022/10/23/60146-%D8%A7%D9%84%D8%A8%D9%88%D9%85-%D8%AA%D8%A7%D9%8A%D9%84%D9%88%D8%B1-%D8%B3%D9%88%D9%8A%D9%81%D8%AA.jpeg',
      'songs': '79 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://upload.wikimedia.org/wikipedia/ar/f/f6/Taylor_Swift_-_1989.png',
      'songs': '23 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273ee0f38410382a255e4fb15f4',
      'songs': '25 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/3/35/The_Eminem_Show.jpg',
      'songs': '25 song'
    },
    {
      'name': 'playlist1',
      'image':
          'https://i.scdn.co/image/ab67616d0000b273dbb3dd82da45b7d7f31b1b42',
      'songs': '215 song'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                width: 80,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: const Color.fromARGB(255, 172, 18, 7),
                    ),
                    Text(
                      "Likes",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(78, 158, 158, 158),
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Text(
                  "+ NEW PLAYLIST",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.55,
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MusicPlayer(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        // صورة البلاي ليست
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            playlist['image']!,
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
                                playlist['name']!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                playlist['songs']!,
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
            ),
          ),
        ],
      ),
    );
  }
}

// محتوى تبويب البودكاست
class PodcastTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Center(
            child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
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
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '321B-Viking Legends: The Peacemaker',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
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
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
                  SizedBox(width: 8),
                  Text(
                    '53min left',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // Save and more options
              Row(
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
