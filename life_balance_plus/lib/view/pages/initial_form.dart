import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_balance_plus/view/appbase.dart';

class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();


  String? _firstName;
  String? _lastName;
  String? _gender;
  double? _weight;
  double? _height;

  List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Form(
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
    );
  }

  Future _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Use the collected user data as needed (e.g., send it to a server or save it locally)
      final firestore = FirebaseFirestore.instance;
      final userRef = firestore.collection('users').doc();
      final userData = {
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'firstName': _firstName,
        'lastName': _lastName,
        'gender': _gender,
        'weight': _weight,
        'height': _height,
      };

      try {
        await userRef.set(userData);

        _formKey.currentState!.reset();
        setState(() {
          _gender = null;
        });

        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AppBase())
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