import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:life_balance_plus/view/appbase.dart';
import 'package:life_balance_plus/view/pages/initial_form.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _userExists() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users').doc(userId);
    final userSnapshot = await userRef.get();
    return userSnapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot!.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(height: 5),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                  ? const Text("Sing in")
                  : const Text('Sign up'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions',
                  style: TextStyle(color: Colors.grey),
                )
              );
            },
          );
        }

        // return _userExists() ? AppBase() : UserProfileForm();
        return AppBase();
      }
    );
  }
}
