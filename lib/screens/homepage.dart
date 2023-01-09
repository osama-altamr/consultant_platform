import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tutorial_app/providers/auth.dart';
import 'package:tutorial_app/screens/categories.dart';
import 'package:tutorial_app/screens/allchats.dart';
import 'package:tutorial_app/screens/favorite.dart';
import 'package:tutorial_app/screens/booking.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

List _pages = [
  CategoriesScreen(),
  ChatsScreen(),
  FavoriteScreen(),
  BookingsSreen(),
];

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isExpert = Provider.of<Auth>(context).personIsExpert;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.amber,
              unselectedColor: Color.fromARGB(100, 255, 215, 0)),

          SalomonBottomBarItem(
              icon: const Icon(CommunityMaterialIcons.chat),
              title: const Text("Chats"),
              selectedColor: Colors.amber,
              unselectedColor: Color.fromARGB(100, 255, 215, 0)),

          /// Likes
          SalomonBottomBarItem(
              icon: const Icon(Icons.favorite),
              title: const Text("Likes"),
              selectedColor: Color(0xFFB48A36),
              unselectedColor: Color.fromARGB(100, 255, 215, 0)),
          if (isExpert)
            SalomonBottomBarItem(
                icon: const Icon(Icons.calendar_month),
                title: const Text("Bookings"),
                selectedColor: Colors.amber,
                unselectedColor: Color.fromARGB(100, 255, 215, 0)),
        ],
      ),
    );
  }
}
