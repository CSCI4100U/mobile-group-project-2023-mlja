import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_balance_plus/authentication/authentication_gate.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/view/pages/login_forward.dart';

class UnitsAndPreferencesSettingsPage extends StatefulWidget {
  const UnitsAndPreferencesSettingsPage({super.key});

  @override
  State<UnitsAndPreferencesSettingsPage> createState() =>
      _UnitsAndPreferencesSettingsPageState();
}

class _UnitsAndPreferencesSettingsPageState
    extends State<UnitsAndPreferencesSettingsPage> {
  UnitsSystem unitsSystem = UnitsSystem.metric;

  @override
  Widget build(BuildContext context) {
    // Get user data from account
    Account? account = Session.instance.account;
    account != null ? unitsSystem = account.unitsSystem : unitsSystem;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Units and Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Units System'),
            ListTile(
              title: const Text('Metric System'),
              leading: Radio(
                value: UnitsSystem.metric,
                groupValue: unitsSystem,
                onChanged: (UnitsSystem? value) {
                  setState(() {
                    unitsSystem = value!;
                    account?.updateAccountInfo(unitsSystem: unitsSystem);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Imperial System'),
              leading: Radio(
                value: UnitsSystem.imperial,
                groupValue: unitsSystem,
                onChanged: (UnitsSystem? value) {
                  setState(() {
                    unitsSystem = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Weight Unit'),
            DropdownButton<String>(
              value: unitsSystem == UnitsSystem.metric ? 'kg' : 'lbs',
              onChanged: (String? value) {
                setState(() {
                  if (value == 'kg') {
                    unitsSystem = UnitsSystem.metric;
                  } else {
                    unitsSystem = UnitsSystem.imperial;
                  }
                });
              },
              items: ['kg', 'lbs'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text('Temperature Unit'),
            DropdownButton<String>(
              value: unitsSystem == UnitsSystem.metric ? '°C' : '°F',
              onChanged: (String? value) {
                setState(() {
                  // You can implement the logic to switch between Celsius and Fahrenheit here.
                });
              },
              items: ['°C', '°F'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text('Distance Unit'),
            DropdownButton<String>(
              value: unitsSystem == UnitsSystem.metric ? 'km' : 'mi',
              onChanged: (String? value) {
                setState(() {
                  // You can implement the logic to switch between kilometers and miles here.
                });
              },
              items: ['km', 'mi'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
