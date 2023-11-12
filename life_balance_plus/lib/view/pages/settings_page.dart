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
