import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
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
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: "Page1"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: "Page2"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: "Page3"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: "Page4"),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Page 1',
            style: TextStyle(fontSize: 24, color: Colors.white)));
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Page 2',
            style: TextStyle(fontSize: 24, color: Colors.white)));
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Page 3',
            style: TextStyle(fontSize: 24, color: Colors.white)));
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
