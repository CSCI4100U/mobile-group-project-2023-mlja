import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:life_balance_plus/firebase_options.dart';
import 'package:life_balance_plus/authentication/authentication_gate.dart';
import 'package:life_balance_plus/app_state.dart';
import 'package:life_balance_plus/data/notifications.dart';

void main() async {
  // Initialize app and Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(
      NotificationManager.fcmBackgroundHandler);

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const App()),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Balance Plus',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF000000, {
          50: Color(0xFF000000),
          100: Color(0xFF000000),
          200: Color(0xFF000000),
          300: Color(0xFF000000),
          400: Color(0xFF000000),
          500: Color(0xFF000000),
          600: Color(0xFF000000),
          700: Color(0xFF000000),
          800: Color(0xFF000000),
          900: Color(0xFF000000),
        }),
        useMaterial3: false,
      ),
      home: const AuthGate(),
    );
  }
}
