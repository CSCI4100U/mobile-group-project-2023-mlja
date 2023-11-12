import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool? enableNotifications = true;
  bool? enableSound = true;
  bool? enableVibration = true;
  TimeOfDay notificationTime = const TimeOfDay(hour: 8, minute: 0);
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
        title: const Text('Notifications Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enable Notifications'),
            CheckboxListTile(
              title: const Text('Enable notifications'),
              value: enableNotifications,
              onChanged: (value) {
                setState(() {
                  enableNotifications = value;
                });
              },
            ),
            const Divider(),
            const Text('Notification Preferences'),
            CheckboxListTile(
              title: const Text('Enable Sound'),
              value: enableSound,
              onChanged: (value) {
                setState(() {
                  enableSound = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Enable Vibration'),
              value: enableVibration,
              onChanged: (value) {
                setState(() {
                  enableVibration = value;
                });
              },
            ),
            const Divider(),
            const Text('Reminder Frequency'),
            ListTile(
              title: Text('$reminderFrequency times a day'),
              onTap: () async {
                final newFrequency = await showDialog<int>(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Select Reminder Frequency'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 1);
                          },
                          child: const Text('1 time a day'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 2);
                          },
                          child: const Text('2 times a day'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 3);
                          },
                          child: const Text('3 times a day'),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                account?.updateAccountInfo(
                  useNotifications: enableNotifications,
                  notificationSound: enableSound,
                  notificationVibration: enableVibration,
                  notificationFrequency: reminderFrequency,
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
