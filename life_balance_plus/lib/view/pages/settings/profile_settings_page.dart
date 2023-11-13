import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  // Define variables to store user profile information.
  String? username = 'John Doe';
  DateTime dateOfBirth = DateTime.now();
  String? gender;
  double? weight = 70.0;
  double? height = 175.0;

  // Displays a date picker and updates date of birth.
  Future<void> _chooseDateOfBirth(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );

    if (date != null && date != dateOfBirth) {
      setState(() => dateOfBirth = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get user data from account
    Account? account = Session.instance.account;
    if (account != null) {
      username = '${account.firstName} ${account.lastName}';
      dateOfBirth = account.dateOfBirth;
      gender = account.gender.name;
      gender = gender![0].toUpperCase() + gender!.substring(1);
      weight = account.weight;
      height = account.height;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Username'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your username',
              ),
              controller: TextEditingController(text: username),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Text('Date of Birth'),
            ElevatedButton(
              onPressed: () => _chooseDateOfBirth(context),
              child: Text('$dateOfBirth'.split(' ')[0]),
            ),
            const SizedBox(height: 20.0),
            const Text('Gender'),
            DropdownButton<String?>(
              value: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
              items: <String?>['Male', 'Female', 'Other']
                  .map((value) => DropdownMenuItem<String?>(
                        value: value,
                        child: Text(value ?? 'Select Gender'),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20.0),
            const Text('Weight (kg)'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your weight',
              ),
              keyboardType: TextInputType.number,
              controller:
                  TextEditingController(text: weight?.toStringAsFixed(1) ?? ''),
              onChanged: (value) {
                setState(() {
                  weight = double.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 20.0),
            const Text('Height (cm)'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your height',
              ),
              keyboardType: TextInputType.number,
              controller:
                  TextEditingController(text: height?.toStringAsFixed(1) ?? ''),
              onChanged: (value) {
                setState(() {
                  height = double.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                account?.updateAccountInfo(
                  firstName: username?.split(' ')[0],
                  lastName: username?.split(' ')[1],
                  dateOfBirth: dateOfBirth,
                  gender: gender,
                  weight: weight,
                  height: height,
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
