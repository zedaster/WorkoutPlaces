import 'package:flutter/material.dart';
import 'package:workout_places_app/view/favorites/favorites_screen.dart';
import 'package:workout_places_app/view/navigator_screen.dart';
import 'package:workout_places_app/view/profile/profile_screen.dart';

import 'places/workout_places_screen.dart';

class WorkoutScaffold extends StatefulWidget {
  const WorkoutScaffold({Key? key}) : super(key: key);

  @override
  _WorkoutScaffoldState createState() => _WorkoutScaffoldState();
}

class _WorkoutScaffoldState extends State<WorkoutScaffold> {
  // TODO: create navigation page interface with appbar getters
  int _currentIndex = 0;
  final _screens = <NavigatorScreen>[
    const WorkoutPlacesScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens[_currentIndex].appBarTitle,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: _screens[_currentIndex].asWidget,
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        // Video about NavigationBar and changing pages https://www.youtube.com/watch?v=xoKqQjSDZ60
        // TODO: Experiment with types
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: const Color(0xFF00EB00),
        unselectedItemColor: Colors.black,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Площадки"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Избранное"),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: "Профиль")
        ],
      ),
    );
  }
}
