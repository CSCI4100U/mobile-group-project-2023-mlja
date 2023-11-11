import 'package:flutter/material.dart';


class Account {
  String email;
  String firstName;
  String lastName;
  double height;         // Height in cm
  double weight;         // Weight in kg
  DateTime dateOfBirth;

  Account({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.height,
    required this.weight,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'height': height,
      'weight': weight,
      'dateOfBirth': dateOfBirth.toString(),
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      height: map['height'],
      weight: map['weight'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
    );
  }

  @override
  String toString() {
    return
      "User(email: $email, firstName: $firstName, lastName: $lastName, height: $height, "
      "weight: $weight, dateOfBirth: ${DateUtils.dateOnly(dateOfBirth).toString()})";
  }
}
