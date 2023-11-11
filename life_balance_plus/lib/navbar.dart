import 'package:flutter/material.dart';
import 'package:life_balance_plus/views/home_page.dart';
import 'package:life_balance_plus/views/workout_page.dart';
import 'package:life_balance_plus/views/diet_page.dart';
import 'package:life_balance_plus/views/settings_page.dart';


/// Base widget for the UI set as the home widget of the `App` instance.
/// Provides a global `Scaffold` with a `BottomNavigationBar` for navigating
/// between the main pages.
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}


/// State of a NavBar.
class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  Widget _currentPage = HomePage();

  /// Navigates to the selected page.
  void _onItemTapped(int index) {
    if(index == _selectedIndex) return;

    setState(() {
      switch(index) {
        case 0: _currentPage = HomePage();
        case 1: _currentPage = WorkoutPage();
        case 2: _currentPage = DietPage();
        case 3: _currentPage = SettingsPage();
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Balance Plus'),
      ),
      body: _currentPage,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        // Hide labels for navbar items
        showSelectedLabels: false,
        showUnselectedLabels: false,

        // Icon colours
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,

        // Items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Diet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
