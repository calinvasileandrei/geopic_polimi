import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geopic_polimi/core/models/news.dart';
import 'package:geopic_polimi/core/models/section.dart';

class NewsSection implements Section<News> {
  String name;
  List<News> sectionDataList;

  NewsSection({
    this.name,
    this.sectionDataList,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'news': sectionDataList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory NewsSection.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NewsSection(
      name: map['name'],
      sectionDataList: List<News>.from(
          map['news']?.map((x) => News.fromMap(x))),
    );
  }

  @override
  String toString() => 'NewsSection(name: $name, news: $sectionDataList)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NewsSection &&
        o.name == name &&
        listEquals(o.sectionDataList, sectionDataList);
  }

  String toJson() => json.encode(toMap());

  factory NewsSection.fromJson(String source) =>
      NewsSection.fromMap(json.decode(source));

}
