import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geopic_polimi/core/models/news.dart';

import 'package:geopic_polimi/core/models/structure.dart';

class NewsSection {
  String name;
  List<News> news;

  NewsSection({
    this.name,
    this.news,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'news': news?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory NewsSection.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NewsSection(
      name: map['name'],
      news: List<News>.from(
          map['news']?.map((x) => News.fromMap(x))),
    );
  }

  @override
  String toString() => 'NewsSection(name: $name, news: $news)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NewsSection &&
        o.name == name &&
        listEquals(o.news, news);
  }

  @override
  int get hashCode => name.hashCode ^ news.hashCode;

  String toJson() => json.encode(toMap());

  factory NewsSection.fromJson(String source) =>
      NewsSection.fromMap(json.decode(source));
}
