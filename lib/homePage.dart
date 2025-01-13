// import 'package:flutter/material.dart';
// import 'package:music_app/CustomWidgets/now_playing.dart';
// import 'package:music_app/Views/navigation-bar-pages/communities/communities.dart';
// import 'package:music_app/Views/navigation-bar-pages/home.dart';
// import 'package:music_app/Views/navigation-bar-pages/me/me.dart';
// import 'package:music_app/Views/navigation-bar-pages/playlist/playlists.dart';
// import 'package:music_app/providers/music_provider.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     Home(),
//     PlayLists(),
//     Communities(),
//     Me(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     MusicProvider musicProvider = Provider.of<MusicProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Main content of the page
//           _pages[_currentIndex],

//           // Mini player at the bottom of the screen
//           Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: NowPlaying(
//                 musicProvider: musicProvider,
//               )),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white30,
//         backgroundColor: Color.fromARGB(115, 49, 49, 49),
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         showSelectedLabels: true,
//         showUnselectedLabels: false,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.library_music), label: "PlayLists"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.people_alt_outlined), label: "Communities"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:music_app/Views/players/now_playing.dart';
import 'package:music_app/Views/navigation-bar-pages/communities/communities.dart';
import 'package:music_app/Views/navigation-bar-pages/home.dart';
import 'package:music_app/Views/navigation-bar-pages/me/me.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/playlists.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:provider/provider.dart';

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
      body: Stack(
        children: [
          // Main content of the page
          Navigator(
            key: GlobalKey<
                NavigatorState>(), // مفتاح للتحكم في النافيجيشن الفرعي
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => _pages[_currentIndex],
              );
            },
          ),

          // Mini player at the bottom of the screen
        ],
      ),
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
