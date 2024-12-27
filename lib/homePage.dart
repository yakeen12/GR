import 'package:flutter/material.dart';
import 'package:music_app/Views/navigation-bar-pages/communities/communities.dart';
import 'package:music_app/Views/navigation-bar-pages/home.dart';
import 'package:music_app/Views/navigation-bar-pages/me/me.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/playlists.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    PlayLists(),
    Communities(),
    Me(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        backgroundColor: Color.fromARGB(115, 49, 49, 49),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), label: "PlayLists"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined), label: "Communities"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}
