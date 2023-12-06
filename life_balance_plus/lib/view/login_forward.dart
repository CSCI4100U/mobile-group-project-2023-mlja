import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/pages/initial_form.dart';
import 'package:life_balance_plus/view/appbase.dart';
import 'package:life_balance_plus/control/account_control.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';

class LoginForward {
  String? userId;
  String? userEmail;
  Map<String, dynamic>? userInfo;

  LoginForward(BuildContext context) {
    _loadUserId();
    _loadUserEmail();
    _loadUserInfo().whenComplete(() {
      if (userId != null && userInfo != null) {
        _loadLocalAccount().whenComplete(() {

          // Navigate to Page A
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AppBase()),
            );
          });
        });
      } else {
        // Navigate to Page B
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => UserProfileForm()),
          );
        });
      }
    });
  }

  void _loadUserId() {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  void _loadUserEmail() {
    userEmail = FirebaseAuth.instance.currentUser?.email;
  }

  Future _loadUserInfo() async {
    final firestore = FirebaseFirestore.instance;
    final query =
        firestore.collection('users').where('userId', isEqualTo: userId);
    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      userInfo = snapshot.docs.first.data();
      userInfo!['userInfoId'] = snapshot.docs.first.id;
    }
  }

  /// Loads account and updates user data.
  Future<void> _loadLocalAccount() async {
    Account? account = await AccountControl.loadAccount(userEmail!);
    if(account == null) {
      account = Account(
        firestoreId: userInfo!['userInfoId'],
        email: userEmail!,
        firstName: userInfo!['firstName'],
        lastName: userInfo!['lastName'],
        gender: Gender.values.byName(userInfo!['gender'].toLowerCase()),
        weight: userInfo!['weight'],
        height: userInfo!['height'],
        dateOfBirth: DateTime.parse(userInfo!['dateOfBirth'])
      );
      AccountControl.addAccount(account);
    }
    else {
      account.updateAccountInfo(
        firestoreId: userInfo!['userInfoId'],
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
}
