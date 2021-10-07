import 'package:flutter/foundation.dart';

class Book {
  late int id;
  late int userId;
  late int pictureId;
  late String title;
  late String category;
  late String description;
  late String conservationState;
  late bool isActive;
  late String location;
  late String imagePath;

  Book(
      {required this.id,
      required this.userId,
      required this.pictureId,
      required this.category,
      required this.title,
      required this.description,
      required this.conservationState,
      required this.isActive,
      required this.location,
      required this.imagePath});

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        userId: json['user_id'],
        pictureId: json['image_id'],
        category: json['category'],
        title: json['title'],
        description: json['description'],
        conservationState: json['conservation_state'],
        isActive: json['is_active'],
        location: json['user']['location'],
        imagePath: json['image']['path']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['picture_id'] = this.pictureId;
    data['category'] = this.category;
    data['description'] = this.description;
    data['title'] = this.title;
    data['conservation_state'] = this.conservationState;
    data['is_active'] = this.isActive;
    data['location'] = this.location;
    return data;
  }
}
