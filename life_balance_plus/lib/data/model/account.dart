import 'package:flutter/material.dart';
import 'package:life_balance_plus/control/account_control.dart';

enum Gender { male, female, other }

enum UnitsSystem { metric, imperial }

class Account {
  int? id;
  String email;
  String firstName;
  String lastName;
  double height; // Height in cm
  double weight; // Weight in kg
  Gender gender;
  DateTime dateOfBirth;
  int caloricIntakeGoal;
  int dailyActivityGoal;
  int waterIntakeGoal;
  UnitsSystem unitsSystem;
  bool useNotifications;
  bool notificationSound;
  bool notificationVibration;
  int notificationFrequency;
  bool useWifi;
  bool useMobileData;
  bool useBluetooth;
  bool useNFC;
  bool useLocation;

  Account({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.height,
    required this.weight,
    required this.gender,
    required this.dateOfBirth,
    this.caloricIntakeGoal = 2000,
    this.dailyActivityGoal = 30,
    this.waterIntakeGoal = 8,
    this.unitsSystem = UnitsSystem.metric,
    this.useNotifications = true,
    this.notificationSound = true,
    this.notificationVibration = true,
    this.notificationFrequency = 1,
    this.useWifi = true,
    this.useMobileData = false,
    this.useBluetooth = true,
    this.useNFC = false,
    this.useLocation = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'height': height,
      'weight': weight,
      'gender': gender.name,
      'dateOfBirth': dateOfBirth.toString(),
      'caloricIntakeGoal': caloricIntakeGoal,
      'dailyActivityGoal': dailyActivityGoal,
      'waterIntakeGoal': waterIntakeGoal,
      'unitsSystem': unitsSystem.name,
      'useNotifications': useNotifications,
      'notificationSound': notificationSound,
      'notificationVibration': notificationVibration,
      'notificationFrequency': notificationFrequency,
      'useWifi': useWifi,
      'useMobileData': useMobileData,
      'useBluetooth': useBluetooth,
      'useNFC': useNFC,
      'useLocation': useLocation,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      height: map['height'],
      weight: map['weight'],
      gender: Gender.values.byName(map['gender']),
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      caloricIntakeGoal: map['caloricIntakeGoal'] ?? 2000,
      dailyActivityGoal: map['dailyActivityGoal'] ?? 30,
      waterIntakeGoal: map['waterIntakeGoal'] ?? 8,
      unitsSystem: UnitsSystem.values.byName(map['unitsSystem'] ?? 'Metric'),
      useNotifications: map['useNotifications'] ?? true,
      notificationSound: map['notificationSound'] ?? true,
      notificationVibration: map['notificationVibration'] ?? true,
      notificationFrequency: map['notificationFrequency'] ?? 1,
      useWifi: map['useWifi'] ?? true,
      useMobileData: map['useMobileData'] ?? false,
      useBluetooth: map['useBluetooth'] ?? true,
      useNFC: map['useNFC'] ?? false,
      useLocation: map['useLocation'] ?? true,
    );
  }

  @override
  String toString() {
    return "User(email: $email, firstName: $firstName, lastName: $lastName, "
        " height: $height, weight: $weight, gender: ${gender.name},  "
        "dateOfBirth: ${DateUtils.dateOnly(dateOfBirth).toString()})";
  }

  /// Calculates the user's age in years from their date of birth.
  int getAge() {
    DateTime present = DateTime.now();
    int age = present.year - dateOfBirth.year;
    int month = present.month - dateOfBirth.month;
    if (month < 0 || (month == 0 && present.day < dateOfBirth.day)) {
      return age - 1;
    } else {
      return age;
    }
  }

  void updateAccountInfo({
    String? firstName,
    String? lastName,
    double? height,
    double? weight,
    String? gender,
    DateTime? dateOfBirth,
    int? caloricIntakeGoal,
    int? dailyActivityGoal,
    int? waterIntakeGoal,
    UnitsSystem? unitsSystem,
    bool? useNotifications,
    bool? notificationSound,
    bool? notificationVibration,
    int? notificationFrequency,
    bool? useWifi,
    bool? useMobileData,
    bool? useBluetooth,
    bool? useNFC,
    bool? useLocation,
  }) {
    if (firstName != null) this.firstName = firstName;
    if (lastName != null) this.lastName = lastName;
    if (height != null) this.height = height;
    if (weight != null) this.weight = weight;
    if (gender != null)
      this.gender = Gender.values.byName(gender.toLowerCase());
    if (dateOfBirth != null) this.dateOfBirth = dateOfBirth;
    if (caloricIntakeGoal != null) this.caloricIntakeGoal = caloricIntakeGoal;
    if (dailyActivityGoal != null) this.dailyActivityGoal = dailyActivityGoal;
    if (waterIntakeGoal != null) this.waterIntakeGoal = waterIntakeGoal;
    if (unitsSystem != null) this.unitsSystem = unitsSystem;
    if (useNotifications != null) this.useNotifications = useNotifications;
    if (notificationSound != null) this.notificationSound = notificationSound;
    if (notificationVibration != null)
      this.notificationVibration = notificationVibration;
    if (notificationFrequency != null)
      this.notificationFrequency = notificationFrequency;
    if (useWifi != null) this.useWifi = useWifi;
    if (useMobileData != null) this.useMobileData = useMobileData;
    if (useBluetooth != null) this.useBluetooth = useBluetooth;
    if (useNFC != null) this.useNFC = useNFC;
    if (useLocation != null) this.useLocation = useLocation;

    AccountControl.updateAccountInfo(this);
  }
}
