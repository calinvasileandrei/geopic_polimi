import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:geopic_polimi/core/models/secretery.dart';

class Person {
  int id; //new
  String name;
  String surname;
  String email;
  String phone;
  Secretary secretary;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Person({
    @required this.id,
    @required this.name,
    @required this.surname,
    @required this.email,
    @required this.phone,
    @required this.secretary,
  });

  Person copyWith({
    int id,
    String name,
    String surname,
    String email,
    String phone,
    Secretary secretary,
  }) {
    return new Person(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      secretary: secretary ?? this.secretary,
    );
  }

  @override
  String toString() {
    return 'Person{id: $id, name: $name, surname: $surname, email: $email, phone: $phone, secretary: $secretary}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          surname == other.surname &&
          email == other.email &&
          phone == other.phone &&
          secretary == other.secretary);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      surname.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      secretary.hashCode;

  factory Person.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Person(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      phone: map['phone'],
      secretary: Secretary.fromMap(map['secretary']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'secretary': secretary?.toMap(),
    };
  }

//</editor-fold>

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}
