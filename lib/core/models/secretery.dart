import 'dart:convert';

import 'package:flutter/material.dart';

class Secretary {
  int id;
  String address;
  String email;
  String name;
  String phone;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Secretary({
    @required this.id,
    @required this.address,
    @required this.email,
    @required this.name,
    @required this.phone,
  });

  Secretary copyWith({
    int id,
    String address,
    String email,
    String name,
    String phone,
  }) {
    return new Secretary(
      id: id ?? this.id,
      address: address ?? this.address,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  @override
  String toString() {
    return 'Secretary{id: $id, address: $address, mail: $email, name: $name, phone: $phone}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Secretary &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          address == other.address &&
          email == other.email &&
          name == other.name &&
          phone == other.phone);

  @override
  int get hashCode =>
      id.hashCode ^
      address.hashCode ^
      email.hashCode ^
      name.hashCode ^
      phone.hashCode;

  factory Secretary.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Secretary(
      id: map['id'],
      address: map['address'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

//</editor-fold>

  String toJson() => json.encode(toMap());

  factory Secretary.fromJson(String source) =>
      Secretary.fromMap(json.decode(source));
}
