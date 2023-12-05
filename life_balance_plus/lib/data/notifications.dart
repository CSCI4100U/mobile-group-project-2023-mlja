import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

class NotificationManager {
  static int _id=0;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late final String? _fcmToken;

  NotificationManager._internal() {
    _initializeNotifications();
  }

  static final NotificationManager _instance = NotificationManager._internal();

  factory NotificationManager() {
    return _instance;
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<PendingNotificationRequest> _queuedNotifications = [];

  void _requestNotificationPermission() async {
    await _fcm.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      announcement: true,
      criticalAlert: true,
      provisional: false,
    );

    // Only for Apple devices:
    // await _fcm.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
  }

  // TODO: handle different types of notifications
  Future<void> setupInteractionMessage() async {
    // gets messages that cause app to be opened from terminated state
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
  }

  // TODO: handle background messages
  @pragma('vm:entry-point')
  static Future<void> fcmBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  Future<void> _initializeNotifications() async {
    tz.initializeTimeZones();
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _requestNotificationPermission();
    _fcmToken = await _fcm.getToken();
    // print('FCM token: ${_fcmToken!}');
  }

  Future<void> _refreshQueuedNotifications() async {
    final List<PendingNotificationRequest> pendingNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    _queuedNotifications = pendingNotifications;
  }

  Future<void> scheduleNotification(
      DateTime scheduledDate,
      String channelId,
      String channelName,
      String channelDescription) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      icon: 'app_icon',
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      _id++,
      channelName,
      "Notification Text",
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    _refreshQueuedNotifications();
  }

}
