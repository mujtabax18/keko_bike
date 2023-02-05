import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });
  final int selectedIndex;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Map',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.warning_amber),
              label: 'S.O.S',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        iconSize: 40,
        onTap:onTap,
        elevation: 5

    );
  }
}