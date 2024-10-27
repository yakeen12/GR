import 'package:flutter/material.dart';
import 'package:music_app/Pages/home.dart';

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
    Me(),
    // Page4(),
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
              icon: Icon(Icons.favorite), label: "PlayLists"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.explore_outlined), label: "Page4"),
        ],
      ),
    );
  }
}

class PlayLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('PlayLists',
            style: TextStyle(fontSize: 24, color: Colors.white)));
  }
}

class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Me', style: TextStyle(fontSize: 24, color: Colors.white)));
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Page 4',
            style: TextStyle(fontSize: 24, color: Colors.white)));
  }
}
