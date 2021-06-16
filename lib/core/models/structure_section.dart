import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/core/models/structure.dart';

class StructureSection implements Section<Structure>{
  String name;
  List<Structure> sectionDataList;

  StructureSection({
    this.name,
    this.sectionDataList,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'structures': sectionDataList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory StructureSection.fromMap(Map<String, dynamic> map,double _userLatitude,double _userLongitude) {
    if (map == null) return null;

    return StructureSection(
      name: map['name'],
      sectionDataList: List<Structure>.from(
          map['structures']?.map((x) => Structure.fromMap(x,_userLatitude,_userLongitude))),
    );
  }

  @override
  String toString() => 'Section(name: $name, structures: $sectionDataList)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StructureSection &&
        o.name == name &&
        listEquals(o.sectionDataList, sectionDataList);
  }

  String toJson() => json.encode(toMap());

  factory StructureSection.fromJson(String source,double _userLatitude,double _userLongitude) =>
      StructureSection.fromMap(json.decode(source),_userLatitude,_userLongitude);
}
