import 'dart:convert';
import 'package:flutter/material.dart';

class User {
  String firstName;
  String lastName;
  String email;
  String token;
  User({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.token,
  });

  User copyWith({
    String firstName,
    String lastName,
    String email,
    String token,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'token': token,
    };
  }

  factory User.fromMapAPI(Map<String, dynamic> map, String token) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      token: token,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.token == token;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
    lastName.hashCode ^
    email.hashCode ^
    token.hashCode;
  }
}
