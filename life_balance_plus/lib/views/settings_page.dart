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
          // Add more settings options here...
        ],
      ),
    );
  }
}

// You can create separate pages for different settings categories.
class ProfileSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: Center(
        child: Text('Profile settings go here'),
      ),
    );
  }
}

class UnitsAndPreferencesSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Units and Preferences'),
      ),
      body: Center(
        child: Text('Units and preferences settings go here'),
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

// Add more settings pages for other categories as needed.
