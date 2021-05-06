import 'package:flutter/material.dart';

class News {
  int id;
  String title;
  String image;
  String description;
  String date;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  News({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.date,
  });

  News copyWith({
    int id,
    String title,
    String image,
    String description,
    String date,
  }) {
    return new News(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'News{id: $id, title: $title, image: $image, description: $description, date: $date}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is News &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              image == other.image &&
              description == other.description &&
              date == other.date
          );

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ image.hashCode ^ description.hashCode ^ date.hashCode;

  factory News.fromMap(Map<String, dynamic> map) {
    return new News(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'title': this.title,
      'image': this.image,
      'description': this.description,
      'date': this.date,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
