import 'package:flutter/material.dart';
import 'package:gdscapp/index.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});
  @override
  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ]);
  }

  void _onItemTapped(int index) async {
    if (index != widget.currentIndex) {
      if (index == 0) {
        switchScreenAndRemoveAll(homePageScreen);
      } else if (index == 1) {
        switchScreen(profileScreen);
      } else {}
    }
  }
}
