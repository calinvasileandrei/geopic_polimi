import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:geopic_polimi/core/models/category.dart';

class GeoPicMarker {
  int id;
  String name;
  Category category;
  String color;
  double latitude;
  double longitude;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  GeoPicMarker({
    @required this.id,
    @required this.name,
    @required this.category,
    @required this.color,
    @required this.latitude,
    @required this.longitude,
  });

  GeoPicMarker copyWith({
    int id,
    String name,
    Category category,
    String color,
    double latitude,
    double longitude,
  }) {
    return new GeoPicMarker(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      color: color ?? this.color,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return 'GerisMarker{id: $id, name: $name, category: $category, color: $color, latitude: $latitude, longitude: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeoPicMarker &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          category == other.category &&
          color == other.color &&
          latitude == other.latitude &&
          longitude == other.longitude);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      category.hashCode ^
      color.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;

  factory GeoPicMarker.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GeoPicMarker(
      id: map['id'],
      name: map['name'],
      category: Category.fromMap(map['category']),
      color: map['color'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category?.toMap(),
      'color': color,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

//</editor-fold>

  String toJson() => json.encode(toMap());

  factory GeoPicMarker.fromJson(String source) =>
      GeoPicMarker.fromMap(json.decode(source));
}
