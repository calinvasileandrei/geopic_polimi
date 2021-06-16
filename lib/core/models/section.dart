import 'package:flutter/foundation.dart';

abstract class Section<T> {
  String name;
  List<T> sectionDataList;

  Section({
    this.name,
    this.sectionDataList,
  });

  @override
  String toString() => 'Section(name: $name, sectionDataList: $sectionDataList)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Section &&
        o.name == name &&
        listEquals(o.sectionDataList, sectionDataList);
  }
}
