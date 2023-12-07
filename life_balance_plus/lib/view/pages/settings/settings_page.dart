import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_balance_plus/authentication/authentication_gate.dart';
import 'package:life_balance_plus/view/pages/settings/export_settings.dart';

/// A page that displays various settings options for the user.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 105,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Profile Information'),
            onTap: () {
              // Navigate to profile settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Units and Preferences'),
            onTap: () {
              // Navigate to units and preferences settings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const UnitsAndPreferencesSettingsPage()));
            },
          ),
          ListTile(
            title: const Text('Notifications'),
            onTap: () {
              // Navigate to notifications settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Goal Settings'),
            onTap: () {
              // Navigate to goal settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GoalSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Connectivity'),
            onTap: () {
              // Navigate to connectivity settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnectivitySettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 196),
          Center(
            child: TextButton(
              // Sign out the user and navigate to the authentication gate
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AuthGate(),
                ));
              },
              child: const Text("Sign Out", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
