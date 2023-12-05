import 'package:flutter/material.dart';

import 'package:life_balance_plus/view/pages/diet/diet_page.dart';
import 'package:life_balance_plus/view/pages/home_page.dart';
import 'package:life_balance_plus/view/pages/settings/settings_page.dart';
import 'package:life_balance_plus/view/pages/workout/workout_page.dart';
import 'package:life_balance_plus/data/notifications.dart';

/// Base widget for the UI. Provides a global `Scaffold` with a `NavigationBar`
/// for navigating between the main pages.
class AppBase extends StatefulWidget {
  AppBase({super.key});

  @override
  State<AppBase> createState() => _AppBaseState();
}

/// State of an `AppBase`.
class _AppBaseState extends State<AppBase> {
  int currentIndex = 0;
  final List<Widget> pages = <Widget>[
    HomePage(),
    WorkoutPage(),
    DietPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    // initializes notifications singleton
    NotificationManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Life Balance Plus'),
      // ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentIndex,
        onDestinationSelected: (int value) =>
            setState(() => currentIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.fitness_center), label: 'Workout'),
          NavigationDestination(icon: Icon(Icons.restaurant), label: 'Diet'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
