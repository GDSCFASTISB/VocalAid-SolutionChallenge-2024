import 'package:flutter/material.dart';
import 'package:gdscapp/index.dart';

class ButtomNavBar extends StatefulWidget {
  ButtomNavBar({super.key});
  @override
  @override
  State<ButtomNavBar> createState() => ButtomNavbarState();
}

class ButtomNavbarState extends State<ButtomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ]);
  }

  void _onItemTapped(int index) async {
    setState(() {
      currentIndex = index;
    });

    if (index == 0) {
    } else if (index == 1) {
    } else {}
  }
}
