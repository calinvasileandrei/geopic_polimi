import 'package:flutter/material.dart';

class Category {
  int id;
  String name;
  String color;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Category({
    @required this.id,
    @required this.name,
    @required this.color,
  });

  Category copyWith({
    int id,
    String name,
    String color,
  }) {
    return new Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, color: $color}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          color == other.color);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;

  factory Category.fromMap(Map<String, dynamic> map) {
    return new Category(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'color': this.color,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
