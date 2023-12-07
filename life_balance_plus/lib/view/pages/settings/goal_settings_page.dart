import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';

/// A page for managing daily goals related to health and wellness.
class GoalSettingsPage extends StatefulWidget {
  const GoalSettingsPage({super.key});

  @override
  State<GoalSettingsPage> createState() => _GoalSettingsPageState();
}

class _GoalSettingsPageState extends State<GoalSettingsPage> {
  int dailyCaloricIntakeGoal = 2000;
  int dailyPhysicalActivityGoal = 30; // in minutes
  int dailyWaterIntakeGoal = 8; // in cups

  @override
  void initState() {
    super.initState();

    // Get user data from account
    Account? account = Session.instance.account;
    if (account != null) {
      dailyCaloricIntakeGoal = account.caloricIntakeGoal;
      dailyPhysicalActivityGoal = account.dailyActivityGoal;
      dailyWaterIntakeGoal = account.waterIntakeGoal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daily Caloric Intake Goal'),
            Slider(
              value: dailyCaloricIntakeGoal.toDouble(),
              onChanged: (value) {
                setState(() {
                  dailyCaloricIntakeGoal = value.round();
                });
              },
              min: 0,
              max: 5000,
              divisions: 100,
              label: dailyCaloricIntakeGoal.toString(),
            ),
            const SizedBox(height: 10.0),
            Text('Daily Caloric Intake Goal: $dailyCaloricIntakeGoal calories'),
            const Divider(),
            const Text('Daily Physical Activity Goal'),
            Slider(
              value: dailyPhysicalActivityGoal.toDouble(),
              onChanged: (value) {
                setState(() {
                  dailyPhysicalActivityGoal = value.round();
                });
              },
              min: 0,
              max: 180, // Assuming a maximum of 3 hours of activity
              divisions: 36, // 36 divisions for each 10 minutes
              label: dailyPhysicalActivityGoal.toString(),
            ),
            const SizedBox(height: 10.0),
            Text(
                'Daily Physical Activity Goal: $dailyPhysicalActivityGoal minutes'),
            const Divider(),
            const Text('Daily Water Intake Goal'),
            Slider(
              value: dailyWaterIntakeGoal.toDouble(),
              onChanged: (value) {
                setState(() {
                  dailyWaterIntakeGoal = value.round();
                });
              },
              min: 0,
              max: 16, // Assuming a maximum of 16 cups
              divisions: 16, // 16 divisions for each cup
              label: dailyWaterIntakeGoal.toString(),
            ),
            const SizedBox(height: 10.0),
            Text('Daily Water Intake Goal: $dailyWaterIntakeGoal cups'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Save updated goal settings to the user's account
                Session.instance.account?.updateAccountInfo(
                  caloricIntakeGoal: dailyCaloricIntakeGoal,
                  dailyActivityGoal: dailyPhysicalActivityGoal,
                  waterIntakeGoal: dailyWaterIntakeGoal,
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
