import 'package:flutter/material.dart';
import 'package:life_balance_plus/control/workouts_control.dart';

import 'package:life_balance_plus/view/pages/diet/diet_page.dart';
import 'package:life_balance_plus/view/pages/home_page.dart';
import 'package:life_balance_plus/view/pages/settings/settings_page.dart';
import 'package:life_balance_plus/view/pages/workout/workout_page.dart';
import 'package:life_balance_plus/data/notifications.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/model/account.dart';

/// Base widget for the UI. Provides a global `Scaffold` with a `NavigationBar`
/// for navigating between the main pages.
class AppBase extends StatefulWidget {
  AppBase({super.key});

  @override
  State<AppBase> createState() => _AppBaseState();
}

/// State of an `AppBase`.
class _AppBaseState extends State<AppBase> {
  int _currentIndex = 0;

  final List<Function> _pages = [
    () => HomePage(),
    () => WorkoutPage(),
    () => DietPage(),
    () => SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();

    // initializes notifications singleton
    NotificationManager();

    _loadTrainingData();
  }

  Future<void> _loadTrainingData() async {
    WorkoutControl control = WorkoutControl();
    Account account = Session.instance.account!;
    Session.instance.workoutPlans = await control.getWorkoutPlans(account);
    Session.instance.fitnessLogs  = await control.getFitnessLogs(account);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Life Balance Plus'),
      // ),
      body: _pages[_currentIndex](),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
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
