import 'package:flutter/material.dart';
import 'package:gdscapp/index.dart';
import 'package:gdscapp/screens/Profile.dart';

class ButtomNavBar extends StatefulWidget {
  ButtomNavBar({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  @override
  State<ButtomNavBar> createState() => ButtomNavbarState();
}

class ButtomNavbarState extends State<ButtomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Challenge")
        ]);
  }

  void _onItemTapped(int index) async {
    if (index != widget.currentIndex) {
      if (index == 0) {
        switchScreen(homePageScreen);
      } else if (index == 1) {
        switchScreen(profileScreen);
      } else {
        switchScreen(challengeScreen);
      }
    }
  }
}
