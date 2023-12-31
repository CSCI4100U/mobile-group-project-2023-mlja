import 'package:flutter/material.dart';
import 'package:life_balance_plus/control/account_control.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';

enum Gender { male, female, other }

enum UnitsSystem { metric, imperial }

class Account {
  WorkoutPlan? activePlan;
  String firestoreId;   // Id of account document in users collection
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
    required this.firestoreId,
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
    this.activePlan,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      firestoreId: map['firestoreId'],
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
      useNotifications: (map['useNotifications'] ?? 1) == 1,
      notificationSound: (map['notificationSound'] ?? 1) == 1,
      notificationVibration: (map['notificationVibration'] ?? 1) == 1,
      notificationFrequency: map['notificationFrequency'],
      useWifi: (map['useWifi'] ?? 1) == 1,
      useMobileData: (map['useMobileData'] ?? 0) == 1,
      useBluetooth: (map['useBluetooth'] ?? 1) == 1,
      useNFC: (map['useNFC'] ?? 0) == 1,
      useLocation: (map['useLocation'] ?? 1) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firestoreId': firestoreId,
      'email': email,
      'caloricIntakeGoal': caloricIntakeGoal,
      'dailyActivityGoal': dailyActivityGoal,
      'waterIntakeGoal': waterIntakeGoal,
      'unitsSystem': unitsSystem.name,
      'useNotifications': useNotifications ? 1 : 0,
      'notificationSound': notificationSound ? 1 : 0,
      'notificationVibration': notificationVibration ? 1 : 0,
      'notificationFrequency': notificationFrequency,
      'useWifi': useWifi? 1:0,
      'useMobileData': useMobileData? 1:0,
      'useBluetooth': useBluetooth? 1:0,
      'useNFC': useNFC? 1:0,
      'useLocation': useLocation? 1:0,
      'active_workout_plan_id': activePlan?.id,
      ...toFirestoreMap()
    };
  }

  /// Creates a map containing only the information stored in the cloud database.
  Map<String, dynamic> toFirestoreMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'height': height,
      'weight': weight,
      'gender': gender.name,
      'dateOfBirth': dateOfBirth.toString(),
    };
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
    WorkoutPlan? activePlan,
    String? firestoreId,
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
    bool updateCloud = false;

    if (activePlan != null) {
      this.activePlan = activePlan;
      updateCloud = true;
    }
    if (firstName != null) {
      this.firstName = firstName;
      updateCloud = true;
    }
    if (lastName != null) {
      this.lastName = lastName;
      updateCloud = true;
    }
    if (height != null) {
      this.height = height;
      updateCloud = true;
    }
    if (weight != null) {
      this.weight = weight;
      updateCloud = true;
    }
    if (gender != null) {
      this.gender = Gender.values.byName(gender.toLowerCase());
      updateCloud = true;
    }
    if (dateOfBirth != null) {
      this.dateOfBirth = dateOfBirth;
      updateCloud = true;
    }

    if (firestoreId != null) this.firestoreId = firestoreId;
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

    AccountControl.updateAccount(this, updateCloud);
  }

  // Copywith method
  Account copyWith({
    String? firestoreId,
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
    return Account(
      firestoreId: firestoreId ?? this.firestoreId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender != null
          ? Gender.values.byName(gender.toLowerCase())
          : this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      caloricIntakeGoal: caloricIntakeGoal ?? this.caloricIntakeGoal,
      dailyActivityGoal: dailyActivityGoal ?? this.dailyActivityGoal,
      waterIntakeGoal: waterIntakeGoal ?? this.waterIntakeGoal,
      unitsSystem: unitsSystem ?? this.unitsSystem,
      useNotifications: useNotifications ?? this.useNotifications,
      notificationSound: notificationSound ?? this.notificationSound,
      notificationVibration:
          notificationVibration ?? this.notificationVibration,
      notificationFrequency:
          notificationFrequency ?? this.notificationFrequency,
      useWifi: useWifi ?? this.useWifi,
      useMobileData: useMobileData ?? this.useMobileData,
      useBluetooth: useBluetooth ?? this.useBluetooth,
      useNFC: useNFC ?? this.useNFC,
      useLocation: useLocation ?? this.useLocation,
    );
  }
}
