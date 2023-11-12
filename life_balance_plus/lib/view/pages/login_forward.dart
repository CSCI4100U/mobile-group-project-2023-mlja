import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:life_balance_plus/view/pages/initial_form.dart';

class LoginForward extends StatefulWidget {
  const LoginForward({super.key});

  @override
  State<LoginForward> createState() => _LoginForwardState();
}

class _LoginForwardState extends State<LoginForward> {
  String? userId;
  Map? userInfo;

  Future _loadUserInfo() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users').doc(userId);
    final userSnapshot = await userRef.get();
    userInfo = userSnapshot.data();
  }

  Future<void> _loadUserId() async {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  Future _sendToForm() async {
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UserProfileForm())
    );
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
