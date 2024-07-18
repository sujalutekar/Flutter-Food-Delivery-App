import 'package:flutter/material.dart';

import 'package:foodie/features/home%20tab/pages/home_page.dart';
import 'package:foodie/features/favorites%20tab/favorites_tab.dart';
import 'package:foodie/features/profile%20tab/profile-page.dart';
import 'package:foodie/theme/app_pallete.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _buildScreens = const [
    HomePage(),
    FavoritesTab(),
    ProfilePage(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.favorite),
      icon: Icon(Icons.favorite_border_outlined),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _buildScreens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 0),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPallete.primaryColor,
          selectedFontSize: 15,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: items,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
