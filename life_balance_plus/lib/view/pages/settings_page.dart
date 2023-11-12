import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_balance_plus/authentication/authentication_gate.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/model/account.dart';

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
          const SizedBox(height: 196),
          Center(
              child: TextButton(
            // TODO: better implement sign-out functionality
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AuthGate(),
              ));
            },
            child: Text("sign out", style: TextStyle(fontSize: 16)),
          ))
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
  String username = 'John Doe';
  DateTime dateOfBirth = DateTime.now();
  String? gender;
  double? weight = 70.0;
  double? height = 175.0;

  /// Displays a date picker and updates date of birth.
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
            Text('Date of Birth'),
            ElevatedButton(
              onPressed: () => _chooseDateOfBirth(context),
              child: Text('$dateOfBirth'.split(' ')[0]),
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
                account?.updateAccountInfo(
                  firstName: username.split(' ')[0],
                  lastName: username.split(' ')[1],
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

class UnitsAndPreferencesSettingsPage extends StatefulWidget {
  @override
  _UnitsAndPreferencesSettingsPageState createState() =>
      _UnitsAndPreferencesSettingsPageState();
}

class _UnitsAndPreferencesSettingsPageState
    extends State<UnitsAndPreferencesSettingsPage> {
  UnitsSystem unitsSystem = UnitsSystem.Metric;

  @override
  Widget build(BuildContext context) {
    // Get user data from account
    Account? account = Session.instance.account;
    if (account != null) {
      unitsSystem = account.unitsSystem;
    }

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
            ListTile(
              title: Text('Metric System'),
              leading: Radio(
                value: UnitsSystem.Metric,
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
              title: Text('Imperial System'),
              leading: Radio(
                value: UnitsSystem.Imperial,
                groupValue: unitsSystem,
                onChanged: (UnitsSystem? value) {
                  setState(() {
                    unitsSystem = value!;
                    account?.updateAccountInfo(unitsSystem: unitsSystem);
                  });
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text('Weight Unit'),
            DropdownButton<String>(
              value: unitsSystem == UnitsSystem.Metric ? 'kg' : 'lbs',
              onChanged: (String? value) {
                setState(() {
                  if (value == 'kg') {
                    unitsSystem = UnitsSystem.Metric;
                  } else {
                    unitsSystem = UnitsSystem.Imperial;
                  }
                });
              },
              items: [
                'kg',
                'lbs',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text('Temperature Unit'),
            DropdownButton<String>(
              value: unitsSystem == UnitsSystem.Metric ? '°C' : '°F',
              onChanged: (String? value) {
                setState(() {
                  // You can implement the logic to switch between Celsius and Fahrenheit here.
                });
              },
              items: [
                '°C',
                '°F',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text('Distance Unit'),
            DropdownButton<String>(
              value: unitsSystem == UnitsSystem.Metric ? 'km' : 'mi',
              onChanged: (String? value) {
                setState(() {
                  // You can implement the logic to switch between kilometers and miles here.
                });
              },
              items: [
                'km',
                'mi',
              ].map((String value) {
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

class NotificationsSettingsPage extends StatefulWidget {
  @override
  _NotificationsSettingsPageState createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool? enableNotifications = true;
  bool? enableSound = true;
  bool? enableVibration = true;
  TimeOfDay notificationTime = TimeOfDay(hour: 8, minute: 0);
  int reminderFrequency = 3;

  @override
  Widget build(BuildContext context) {
    // Get user data from account
    Account? account = Session.instance.account;
    if (account != null) {
      enableNotifications = account.useNotifications;
      enableSound = account.notificationSound;
      enableVibration = account.notificationVibration;
      reminderFrequency = account.notificationFrequency;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enable Notifications'),
            CheckboxListTile(
              title: Text('Enable notifications'),
              value: enableNotifications,
              onChanged: (value) {
                setState(() {
                  enableNotifications = value;
                });
              },
            ),
            Divider(),
            Text('Notification Preferences'),
            CheckboxListTile(
              title: Text('Enable Sound'),
              value: enableSound,
              onChanged: (value) {
                setState(() {
                  enableSound = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Enable Vibration'),
              value: enableVibration,
              onChanged: (value) {
                setState(() {
                  enableVibration = value;
                });
              },
            ),
            Divider(),
            Text('Reminder Frequency'),
            ListTile(
              title: Text('$reminderFrequency times a day'),
              onTap: () async {
                final newFrequency = await showDialog<int>(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Select Reminder Frequency'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 1);
                          },
                          child: Text('1 time a day'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 2);
                          },
                          child: Text('2 times a day'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 3);
                          },
                          child: Text('3 times a day'),
                        ),
                        // Add more options as needed.
                      ],
                    );
                  },
                );

                if (newFrequency != null) {
                  setState(() {
                    reminderFrequency = newFrequency;
                  });
                }
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                account?.updateAccountInfo(
                  useNotifications: enableNotifications,
                  notificationSound: enableSound,
                  notificationVibration: enableVibration,
                  notificationFrequency: reminderFrequency,
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

class GoalSettingsPage extends StatefulWidget {
  @override
  _GoalSettingsPageState createState() => _GoalSettingsPageState();
}

class _GoalSettingsPageState extends State<GoalSettingsPage> {
  int dailyCaloricIntakeGoal = 2000;
  int dailyPhysicalActivityGoal = 30; // in minutes
  int dailyWaterIntakeGoal = 8; // in cups

  @override
  Widget build(BuildContext context) {
    // Get user data from account
    Account? account = Session.instance.account;
    if (account != null) {
      dailyCaloricIntakeGoal = account.caloricIntakeGoal;
      dailyPhysicalActivityGoal = account.dailyActivityGoal;
      dailyWaterIntakeGoal = account.waterIntakeGoal;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Goal Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Caloric Intake Goal'),
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
            SizedBox(height: 10.0),
            Text('Daily Caloric Intake Goal: $dailyCaloricIntakeGoal calories'),
            Divider(),
            Text('Daily Physical Activity Goal'),
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
            SizedBox(height: 10.0),
            Text(
                'Daily Physical Activity Goal: $dailyPhysicalActivityGoal minutes'),
            Divider(),
            Text('Daily Water Intake Goal'),
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
            SizedBox(height: 10.0),
            Text('Daily Water Intake Goal: $dailyWaterIntakeGoal cups'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                account?.updateAccountInfo(
                  caloricIntakeGoal: dailyCaloricIntakeGoal,
                  dailyActivityGoal: dailyPhysicalActivityGoal,
                  waterIntakeGoal: dailyWaterIntakeGoal,
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

class ConnectivitySettingsPage extends StatefulWidget {
  @override
  _ConnectivitySettingsPageState createState() =>
      _ConnectivitySettingsPageState();
}

class _ConnectivitySettingsPageState extends State<ConnectivitySettingsPage> {
  bool? enableWifi = true;
  bool? enableMobileData = true;
  bool? enableBluetooth = true;
  bool? enableNFC = false;
  bool? enableLocationServices = true;

  @override
  Widget build(BuildContext context) {
    // Get user data from account
    Account? account = Session.instance.account;
    if (account != null) {
      enableWifi = account.useWifi;
      enableMobileData = account.useMobileData;
      enableNFC = account.useNFC;
      enableLocationServices = account.useLocation;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wi-Fi'),
            CheckboxListTile(
              title: Text('Enable Wi-Fi'),
              value: enableWifi,
              onChanged: (value) {
                setState(() {
                  enableWifi = value;
                });
              },
            ),
            Divider(),
            Text('Mobile Data'),
            CheckboxListTile(
              title: Text('Enable Mobile Data'),
              value: enableMobileData,
              onChanged: (value) {
                setState(() {
                  enableMobileData = value;
                });
              },
            ),
            Divider(),
            Text('Bluetooth'),
            CheckboxListTile(
              title: Text('Enable Bluetooth'),
              value: enableBluetooth,
              onChanged: (value) {
                setState(() {
                  enableBluetooth = value;
                });
              },
            ),
            Divider(),
            Text('NFC (Near Field Communication)'),
            CheckboxListTile(
              title: Text('Enable NFC'),
              value: enableNFC,
              onChanged: (value) {
                setState(() {
                  enableNFC = value;
                });
              },
            ),
            Divider(),
            Text('Location Services'),
            CheckboxListTile(
              title: Text('Enable Location Services'),
              value: enableLocationServices,
              onChanged: (value) {
                setState(() {
                  enableLocationServices = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                account?.updateAccountInfo(
                  useWifi: enableWifi,
                  useMobileData: enableMobileData,
                  useBluetooth: enableBluetooth,
                  useNFC: enableNFC,
                  useLocation: enableLocationServices,
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
