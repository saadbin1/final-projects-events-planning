import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferences {
  String preferredCity;

  UserPreferences({required this.preferredCity});

  Map<String, dynamic> toMap() {
    return {
      'preferredCity': preferredCity,
    };
  }

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      preferredCity: map['preferredCity'] ?? 'London',
    );
  }
}
