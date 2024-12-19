import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';

class PlayLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
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
              labelStyle: TextStyle(color: Colors.black), // Set accent color

              prefixIcon: Icon(Icons.search),

              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        SizedBox(
          height: 30,
        ),
        Expanded(
          // height: MediaQuery.sizeOf(context).height * 0.8,
          child: DefaultTabController(
            length: 2,
            child: Expanded(
              // height: MediaQuery.sizeOf(context).height * 0.7,
              child: SingleChildScrollView(
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
                      height: MediaQuery.sizeOf(context).height * 0.73,
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
      padding: const EdgeInsets.all(8.0),
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
                return Container(
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
                      Expanded(
                        child: Column(
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
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
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
        return ListTile(
          leading: Icon(Icons.mic, color: Colors.orange, size: 30),
          title: Text('بودكاست ${index + 1}', style: TextStyle(fontSize: 18)),
          subtitle: Text('المضيف ${index + 1}'),
          trailing: Icon(Icons.play_arrow, color: Colors.grey),
          onTap: () {},
        );
      },
    );
  }
}
