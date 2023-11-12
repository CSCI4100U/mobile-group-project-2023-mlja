import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/pages/initial_form.dart';
import 'package:life_balance_plus/view/appbase.dart';
import 'package:life_balance_plus/view/pages/initial_form.dart';

class LoginForward extends StatefulWidget {
  const LoginForward({super.key});

  @override
  State<LoginForward> createState() => _LoginForwardState();
}

class _LoginForwardState extends State<LoginForward> {
  String? userId;
  bool hasInfo = false;
  Map<String, dynamic>? userInfo;

  Future<void> _loadUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future _loadUserInfo() async {
    final firestore = FirebaseFirestore.instance;
    final query =
        firestore.collection('users').where('userId', isEqualTo: userId);
    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        hasInfo = true;
        userInfo = snapshot.docs.first.data();
      });
    }
  }

  Future _sendToForm() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserProfileForm()));
  }

  @override
  void initState() {
    _loadUserId();
    _loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (userId != null && userInfo != null) {
      // Navigate to Page A
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AppBase(userData: userInfo)),
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
