import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_balance_plus/control/account_control.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';

import 'package:life_balance_plus/view/pages/initial_form.dart';

import '../appbase.dart';
import 'initial_form.dart';

class LoginForward extends StatefulWidget {
  const LoginForward({super.key});

  @override
  State<LoginForward> createState() => _LoginForwardState();
}

class _LoginForwardState extends State<LoginForward> {
  String? userId;
  String? userEmail;
  bool hasInfo = false;
  Map<String, dynamic>? userInfo;

  Future<void> _loadUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> _loadUserEmail() async {
    userEmail = FirebaseAuth.instance.currentUser?.email;
  }

  Future _loadUserInfo() async {
    final firestore = FirebaseFirestore.instance;
    final query = firestore.collection('users').where('userId', isEqualTo: userId);
    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        hasInfo = true;
        userInfo = snapshot.docs.first.data();
      });
    }
  }

  /// Loads account and updates user data.
  void _loadLocalAccount() async {
    Account? account = await AccountControl.loadAccount(userEmail!);
    if(account == null) {
      account = Account(
        email: userEmail!,
        firstName: userInfo!['firstName'],
        lastName: userInfo!['lastName'],
        gender: Gender.values.byName(userInfo!['gender'].toLowerCase()),
        weight: userInfo!['weight'],
        height: userInfo!['height'],
        dateOfBirth: DateTime.parse(userInfo!['dateOfBirth'])
      );
    }
    else {
      account.updateAccountInfo(
        firstName: userInfo!['firstName'],
        lastName: userInfo!['lastName'],
        gender: userInfo!['gender'],
        weight: userInfo!['weight'],
        height: userInfo!['height'],
        dateOfBirth: DateTime.parse(userInfo!['dateOfBirth'])
      );
    }

    Session.instance.account = account;
  }

  Future _sendToForm() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserProfileForm())
    );
  }

  @override
  void initState() {
    _loadUserId();
    _loadUserInfo();
    _loadUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    if (userId != null && userInfo != null) {
      _loadLocalAccount();

      // Navigate to Page A
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AppBase()),
        );
      });
    } else {
      // Navigate to Page B
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UserProfileForm()),
        );
      });
    }

    // Return a placeholder widget (this will not be displayed)
    return Container();
  }
}
