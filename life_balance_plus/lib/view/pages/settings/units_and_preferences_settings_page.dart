import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/model/account.dart';

class UnitsAndPreferencesSettingsPage extends StatefulWidget {
  const UnitsAndPreferencesSettingsPage({super.key});

  @override
  State<UnitsAndPreferencesSettingsPage> createState() =>
      _UnitsAndPreferencesSettingsPageState();
}

class _UnitsAndPreferencesSettingsPageState extends State<UnitsAndPreferencesSettingsPage> {
  UnitsSystem unitsSystem = UnitsSystem.metric;

  @override
  void initState() {
    super.initState();

    // Get user data from account
    Account? account = Session.instance.account;
    if(account != null) {
      unitsSystem = account.unitsSystem;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Session.instance.account?.updateAccountInfo(unitsSystem: unitsSystem);
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
                    Session.instance.account?.updateAccountInfo(unitsSystem: unitsSystem);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
