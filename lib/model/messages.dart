import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String image;
  final String title;
  final String subtitle;
  final String author;
  // final String timestamp;
  final String scripture;
  Messages({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.author,
    // required this.timestamp,
    required this.scripture,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'image': image});
    result.addAll({'title': title});
    result.addAll({'subtitle': subtitle});
    result.addAll({'author': author});
    // result.addAll({'timestamp': timestamp});
    result.addAll({'scripture': scripture});

    return result;
  }

  static Messages fromMap(DocumentSnapshot map) {
    var snapshot = map.data() as Map<String, dynamic>;
    return Messages(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      author: map['author'] ?? '',
      // timestamp: map['timestamp'] ?? '',
      scripture: map['scripture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Messages.fromJson(String source) =>
      Messages.fromMap(json.decode(source));
}
