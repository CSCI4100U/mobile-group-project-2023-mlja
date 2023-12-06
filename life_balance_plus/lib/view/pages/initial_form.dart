import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_balance_plus/view/appbase.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/control/account_control.dart';

class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();


  String? _firstName;
  String? _lastName;
  String? _gender;
  DateTime? _dateOfBirth = DateTime.now();
  double? _weight;
  double? _height;

  final List<String> _genders = ['Male', 'Female', 'Other'];

  /// Displays a date picker and updates date of birth.
  Future<void> _chooseDateOfBirth(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );

    if(date != null && date != _dateOfBirth) {
      setState(() => _dateOfBirth = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text('User Information'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _firstName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lastName = value;
                    },
                  ),
                  DropdownButtonFormField(
                    items: _genders.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value as String;
                      });
                    },
                    value: _gender,
                    decoration: InputDecoration(labelText: 'Gender'),
                  ),
                  SizedBox(height: 16),
                  Text('Date of Birth'),
                  ElevatedButton(
                    onPressed: () => _chooseDateOfBirth(context),
                    child: Text('$_dateOfBirth'.split(' ')[0]),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _weight = double.tryParse(value!);
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _height = double.tryParse(value!);
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Use the collected user data as needed (e.g., send it to a server or save it locally)
      final firestore = FirebaseFirestore.instance;
      final userRef = firestore.collection('users').doc();
      final userData = <String, dynamic>{
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'firstName': _firstName,
        'lastName': _lastName,
        'gender': _gender,
        'dateOfBirth': '$_dateOfBirth'.split(' ')[0],
        'weight': _weight,
        'height': _height,
      };

      try {
        await userRef.set(userData);
        _formKey.currentState!.reset();
        setState(() => _gender = null);

        // Load account and update user data
        String? userEmail = FirebaseAuth.instance.currentUser?.email;
        Account? account = await AccountControl.loadAccount(userEmail!);
        if(account == null) {
          account = Account(
            firestoreId: userRef.id,
            email: userEmail,
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            gender: Gender.values.byName(userData['gender'].toLowerCase()),
            weight: userData['weight'],
            height: userData['height'],
            dateOfBirth: DateTime.parse(userData['dateOfBirth'])
          );
          AccountControl.addAccount(account);
        }
        else {
          account.updateAccountInfo(
            firestoreId: userRef.id,
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            gender: userData['gender'],
            weight: userData['weight'],
            height: userData['height'],
            dateOfBirth: DateTime.parse(userData['dateOfBirth'])
          );
        }
        Session.instance.account = account;

        // Load main app contents
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AppBase())
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Couldn't add info! Maybe no internet connection? :("),
            duration: Duration(seconds: 6),
          )
        );
      }
      // Clear the form
    }
  }
}