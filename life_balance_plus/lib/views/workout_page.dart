import 'package:flutter/material.dart';
import 'package:life_balance_plus/views/home_page.dart';


class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Workout Page'),
      ),
    );
  }
}
