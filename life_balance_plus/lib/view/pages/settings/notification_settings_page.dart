import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<PendingNotificationRequest> _queuedNotifications = [];

  int _id = 0;
  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _refreshQueuedNotifications();
  }

  Future<void> _refreshQueuedNotifications() async {
    final List<PendingNotificationRequest> pendingNotifications =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    setState(() {
      _queuedNotifications = pendingNotifications;
    });
  }
  Future<void> _scheduleNotification(DateTime scheduledDate) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      icon: 'app_icon',
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      _id++,
      'Scheduled Notification',
      'This is coming at ${scheduledDate.hour}:${scheduledDate.minute}:${scheduledDate.second}',
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,  // Allow the notification to be shown even when the device is in low-power idle modes.
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, // Interpret the scheduled date and time as an absolute timestamp
    );
  }

  Future<void> _deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    _refreshQueuedNotifications();
  }


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
