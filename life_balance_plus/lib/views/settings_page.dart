import 'package:flutter/material.dart';
import 'package:life_balance_plus/views/home_page.dart';


class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
