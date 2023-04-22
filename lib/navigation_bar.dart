import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shineradio/screens/home_page.dart';
import 'package:shineradio/screens/message.dart';
import 'package:shineradio/screens/now_playing.dart';
import 'package:shineradio/screens/radio.dart';
import 'package:shineradio/screens/schedule.dart';
import 'package:shineradio/screens/welcome.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  static AudioPlayer player = AudioPlayer();
  int selected = 0;
  List screen = [
    // WelcomeScreen(),
    HomePage(player: player),
    RadioScreen(player),
    NowPlaying(),
    // Message(),
    // Center(
    //   child: Text('empty'),
    // ),
    Schedule(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[selected],
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.red,
        // currentIndex: selected,
        onTabChangedListener: (value) {
          setState(() {
            selected = value;
          });
        },
        // type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.blue,
        // selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.white54,
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.search, title: "Search"),
          TabData(iconData: Icons.shopping_cart, title: "Basket")
        ],
      ),
    );
  }
}
