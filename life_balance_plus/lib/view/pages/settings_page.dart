import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Profile Information'),
            onTap: () {
              // Navigate to profile settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsPage()));
            },
          ),
          ListTile(
            title: Text('Units and Preferences'),
            onTap: () {
              // Navigate to units and preferences settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UnitsAndPreferencesSettingsPage()));
            },
          ),
          ListTile(
            title: Text('Notifications'),
            onTap: () {
              // Navigate to notifications settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsSettingsPage()));
            },
          ),
          ListTile(
            title: Text('Goal Settings'),
            onTap: () {
              // Navigate to goal settings
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GoalSettingsPage()));
            },
          ),
          ListTile(
            title: Text('Connectivity'),
            onTap: () {
              // Navigate to connectivity settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConnectivitySettingsPage()));
            },
          ),
          ListTile(
            title: Text('Data Management'),
            onTap: () {
              // Navigate to data management settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataManagementSettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  // Define variables to store user profile information.
  String? username = 'John Doe';
  int? age = 30;
  String? gender;
  double? weight = 70.0;
  double? height = 175.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your username',
              ),
              controller: TextEditingController(text: username),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text('Age'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your age',
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: age?.toString() ?? ''),
              onChanged: (value) {
                setState(() {
                  age = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 20.0),
            Text('Gender'),
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
            SizedBox(height: 20.0),
            Text('Weight (kg)'),
            TextField(
              decoration: InputDecoration(
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
            SizedBox(height: 20.0),
            Text('Height (cm)'),
            TextField(
              decoration: InputDecoration(
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Save the updated profile information to the server or storage here.
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class UnitsAndPreferencesSettingsPage extends StatefulWidget {
  @override
  _UnitsAndPreferencesSettingsPageState createState() =>
      _UnitsAndPreferencesSettingsPageState();
}

class _UnitsAndPreferencesSettingsPageState
    extends State<UnitsAndPreferencesSettingsPage> {
  bool useMetricSystem = true;
  int dailyGoal = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Units and Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Units System'),
            Row(
              children: [
                Text('Use Metric System'),
                Switch(
                  value: useMetricSystem,
                  onChanged: (value) {
                    setState(() {
                      useMetricSystem = value;
                    });
                  },
                ),
              ],
            ),
            Divider(),
            Text('Daily Goal'),
            Slider(
              value: dailyGoal.toDouble(),
              onChanged: (value) {
                setState(() {
                  dailyGoal = value.round();
                });
              },
              min: 0,
              max: 5000,
              divisions: 100,
              label: dailyGoal.toString(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Save the updated units and preferences to the server or storage here.
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Settings'),
      ),
      body: Center(
        child: Text('Notifications settings go here'),
      ),
    );
  }
}

class GoalSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal Settings'),
      ),
      body: Center(
        child: Text('Goal settings go here'),
      ),
    );
  }
}

class ConnectivitySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Settings'),
      ),
      body: Center(
        child: Text('Connectivity settings go here'),
      ),
    );
  }
}

class DataManagementSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Management Settings'),
      ),
      body: Center(
        child: Text('Data management settings go here'),
      ),
    );
  }
}
