import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:music_app/Views/navigation-bar-pages/me/me.dart';
import 'package:music_app/Views/navigation-bar-pages/me/meeye.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showAppBar) setState(() => _showAppBar = false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showAppBar) setState(() => _showAppBar = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // for search
    filteredItems = allItems;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  //Listtttt
  List<String> allItems = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Pineapple'
  ];
  List<String> filteredItems = [];

  void _filterItems(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (_showAppBar)
            SliverAppBar(
              pinned: true,
              floating: true,
              title: Container(
                padding: EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            enabled: false,
                            onTap: () {},
                            style: TextStyle(color: Colors.black),
                            onChanged: _filterItems,
                            decoration: InputDecoration(
                              labelText:
                                  'Search...', // Use confirmation text as label if provided, else use default label text
                              labelStyle: TextStyle(
                                  color: Colors.black), // Set accent color

                              prefixIcon: Icon(Icons.search),

                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Meeye()),
                                );
                              },
                              child: Icon(
                                Icons.card_giftcard_outlined,
                                color: Colors.white,
                                size: 33.2,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Meeye()),
                                );
                              },
                              child: CircleAvatar(
                                maxRadius: 40,
                                backgroundColor: Colors.amberAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filteredItems[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.black,
            ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) => Container(
          //       height: 50,
          //       width: 100,
          //       color: Colors.deepPurple,
          //       margin: EdgeInsets.all(10),
          //     ),
          //     childCount: 50,
          //   ),
          // ),
          // Section: "More of what you like"
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More of what you like',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Suggestions based on what you\'ve liked or played',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Horizontal list using SliverToBoxAdapter
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RecommendationCard(
                    imageUrl: 'https://example.com/album1.jpg',
                    title: 'Pouya - Daddy Issues',
                    subtitle: 'Related tracks',
                  ),
                  RecommendationCard(
                    imageUrl: 'https://example.com/album2.jpg',
                    title: 'GHOSTEMANE - Rake',
                    subtitle: 'Related tracks',
                  ),
                  RecommendationCard(
                    imageUrl: 'https://example.com/album3.jpg',
                    title: 'Hate On Me',
                    subtitle: 'Related tracks',
                  ),
                ],
              ),
            ),
          ),

          // Section: "Artists you should know"
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Artists you should know',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Top tracks from artists similar to Lil Pump',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Grid for artists using SliverList
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // Replace this with your data
                  final List<Map<String, String>> artists = [
                    {
                      'title': 'Famous Dex',
                      'imageUrl': 'https://example.com/artist1.jpg'
                    },
                    {
                      'title': 'SKI MASK THE SLUMP GOD',
                      'imageUrl': 'https://example.com/artist2.jpg'
                    },
                    {
                      'title': 'SUICIDEBOYS',
                      'imageUrl': 'https://example.com/artist3.jpg'
                    },
                  ];

                  return RecommendationCard(
                    imageUrl: artists[index]['imageUrl']!,
                    title: artists[index]['title']!,
                    subtitle: '',
                  );
                },
                childCount: 3, // عدد العناصر في الشبكة
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const RecommendationCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
      ],
    );
  }
}
