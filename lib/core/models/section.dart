import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geopic_polimi/core/models/structure.dart';

class Section {
  String name;
  List<Structure> structures;

  Section({
    this.name,
    this.structures,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'structures': structures?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Section.fromMap(Map<String, dynamic> map,double _userLatitude,double _userLongitude) {
    if (map == null) return null;

    return Section(
      name: map['name'],
      structures: List<Structure>.from(
          map['structures']?.map((x) => Structure.fromMap(x,_userLatitude,_userLongitude))),
    );
  }

  @override
  String toString() => 'Section(name: $name, structures: $structures)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Section &&
        o.name == name &&
        listEquals(o.structures, structures);
  }

  @override
  int get hashCode => name.hashCode ^ structures.hashCode;

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source,double _userLatitude,double _userLongitude) =>
      Section.fromMap(json.decode(source),_userLatitude,_userLongitude);
}
