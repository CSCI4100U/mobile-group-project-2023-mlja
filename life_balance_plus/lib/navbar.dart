import 'package:flutter/material.dart';
import 'package:life_balance_plus/views/home_page.dart';
import 'package:life_balance_plus/views/workout_page.dart';
import 'package:life_balance_plus/views/diet_page.dart';
import 'package:life_balance_plus/views/settings_page.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}


class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  Widget _currentPage = HomePage();

  void _onItemTapped(int index) {
    switch(index) {
      case 0: _currentPage = HomePage();
      case 1: _currentPage = WorkoutPage();
      case 2: _currentPage = DietPage();
      case 3: _currentPage = SettingsPage();
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Life Balance Plus'),
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
