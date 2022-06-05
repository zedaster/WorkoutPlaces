import 'package:flutter/material.dart';

import 'places/workout_places_screen.dart';

class WorkoutScaffold extends StatefulWidget {
  const WorkoutScaffold({Key? key}) : super(key: key);

  @override
  _WorkoutScaffoldState createState() => _WorkoutScaffoldState();
}

class _WorkoutScaffoldState extends State<WorkoutScaffold> {
  // TODO: create navigation page interface with appbar getters
  // TODO: change to screen class instances
  int _currentIndex = 0;
  final _screens = [
    const WorkoutPlacesScreen(),
    const Center(child: Text("Favourites Page")),
    const Center(child: Text("Profile and Settings Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Площадки",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
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
