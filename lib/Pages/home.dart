import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
                height: 80,
                child: Column(
                  children: [
                    Row(
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
                        Expanded(child: SizedBox()),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                            maxRadius: 40,
                            backgroundColor: Colors.amberAccent,
                          ),
                        )
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                height: 50,
                width: 100,
                color: Colors.deepPurple,
                margin: EdgeInsets.all(10),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
