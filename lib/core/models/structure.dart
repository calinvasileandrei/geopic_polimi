import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/person.dart';
import 'package:geopic_polimi/core/models/secretery.dart';

class Structure {
  int id;
  String address;
  String description;
  int discount;
  String email;
  String expireDateConvention;
  double latitude;
  double longitude;
  String logo;
  String macroCategory;
  String name;
  String phone;
  String website;
  Category category;
  double distanceFromYou;
  double userLatitude;
  double userLongitude;
  //reference
  Person referralPerson;
  Secretary secretary;
//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Structure({
    @required this.id,
    @required this.address,
    @required this.description,
    @required this.discount,
    @required this.email,
    @required this.expireDateConvention,
    @required this.latitude,
    @required this.longitude,
    @required this.logo,
    @required this.macroCategory,
    @required this.name,
    @required this.phone,
    @required this.website,
    @required this.category,
    @required this.referralPerson,
    @required this.secretary,
    @required this.distanceFromYou,
    @required this.userLatitude,
    @required this.userLongitude,

  });

  Structure copyWith({
    int id,
    String address,
    String description,
    int discount,
    String email,
    String expireDateConvention,
    double latitude,
    double longitude,
    String logo,
    String macroCategory,
    String name,
    String phone,
    String website,
    Category category,
    Person referralPerson,
    Secretary secretary,
    double discanceFromYou,
    double userLatitude,
    double userLongitude
  }) {
    return new Structure(
      id: id ?? this.id,
      address: address ?? this.address,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      email: email ?? this.email,
      expireDateConvention: expireDateConvention ?? this.expireDateConvention,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      logo: logo ?? this.logo,
      macroCategory: macroCategory ?? this.macroCategory,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      category: category ?? this.category,
      referralPerson: referralPerson ?? this.referralPerson,
      secretary: secretary ?? this.secretary,
      distanceFromYou: distanceFromYou ?? this.distanceFromYou,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude
    );
  }

  @override
  String toString() {
    return 'Structure{id: $id, address: $address, description: $description, discount: $discount, email: $email, expireDateConvention: $expireDateConvention, latitude: $latitude, longitude: $longitude, logo: $logo, macroCategory: $macroCategory, name: $name, phone: $phone, website: $website, category: $category, referralPerson: $referralPerson, secretary: $secretary, distanceFromYou: $distanceFromYou}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Structure &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          address == other.address &&
          description == other.description &&
          discount == other.discount &&
          email == other.email &&
          expireDateConvention == other.expireDateConvention &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          logo == other.logo &&
          macroCategory == other.macroCategory &&
          name == other.name &&
          phone == other.phone &&
          website == other.website &&
          category == other.category &&
          referralPerson == other.referralPerson &&
          secretary == other.secretary &&
          distanceFromYou == other.distanceFromYou &&
          userLatitude == other.userLatitude &&
          userLongitude == other.userLongitude
      );

  @override
  int get hashCode =>
      id.hashCode ^
      address.hashCode ^
      description.hashCode ^
      discount.hashCode ^
      email.hashCode ^
      expireDateConvention.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      logo.hashCode ^
      macroCategory.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      website.hashCode ^
      category.hashCode ^
      referralPerson.hashCode ^
      secretary.hashCode ^
      distanceFromYou.hashCode ^
      userLatitude.hashCode ^
      userLongitude.hashCode;

  factory Structure.fromMap(Map<String, dynamic> map,double _userLatitude,double _userLongitude) {
    if (map == null) return null;

    return Structure(
      id: map['id'],
      address: map['address'],
      description: map['description'],
      discount: map['discount'],
      email: map['email'],
      expireDateConvention: map['expireDateConvention'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      logo: map['logo'],
      macroCategory: map['macroCategory'],
      name: map['name'],
      phone: map['phone'],
      website: map['website'],
      category: Category.fromMap(map['category']),
      referralPerson: Person.fromMap(map['referralPerson']),
      secretary: Secretary.fromMap(map['secretary']),
      distanceFromYou: distance(map['latitude'],map['longitude'],_userLatitude,_userLongitude),
      userLatitude: _userLatitude,
      userLongitude: _userLongitude
    );
  }


  static deg2rad(deg) {
    return (deg * math.pi / 180.0);
  }

  static rad2deg(rad) {
    return (rad * 180.0 / math.pi);
  }

  static double distance(double lat1, double lon1, double lat2, double lon2) {
    double theta = lon1 - lon2;
    double dist = math.sin(deg2rad(lat1)) * math.sin(deg2rad(lat2)) + math.cos(deg2rad(lat1)) * math.cos(deg2rad(lat2)) * math.cos(deg2rad(theta));
    dist = math.acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    dist = dist * 1.609344;

    return (dist);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'description': description,
      'discount': discount,
      'email': email,
      'expireDateConvention': expireDateConvention,
      'latitude': latitude,
      'longitude': longitude,
      'logo': logo,
      'macroCategory': macroCategory,
      'name': name,
      'phone': phone,
      'website': website,
      'category': category?.toMap(),
      'referralPerson': referralPerson?.toMap(),
      'secretary': secretary?.toMap(),
      'distanceFromYou': distanceFromYou,
      'userLatitude':userLatitude,
      'userLongitude': userLongitude
    };
  }

//</editor-fold>

  String toJson() => json.encode(toMap());

  factory Structure.fromJson(String source,double _userLatitude,double _userLongitude) =>
      Structure.fromMap(json.decode(source),_userLatitude,_userLongitude);
}
