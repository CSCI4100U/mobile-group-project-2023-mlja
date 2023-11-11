
class User {
  String firstName;
  String lastName;
  String email;

  User({required this.firstName, required this.lastName, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
    );
  }

  @override
  String toString() {
    return "User(firstName: $firstName, lastName: $lastName, email: $email)";
  }
}