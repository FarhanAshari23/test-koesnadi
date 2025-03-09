import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_koesnadi/domain/entities/notes/notes.dart';

class NotesModel {
  final String title;
  final String content;
  final Timestamp createdAt;
  String? code;

  NotesModel({
    required this.title,
    required this.content,
    required this.createdAt,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      code: map['code'] ?? '',
    );
  }
}

extension NotesModelX on NotesModel {
  NotesEntity toEntity() {
    return NotesEntity(
      title: title,
      content: content,
      createdAt: createdAt,
      code: code!,
    );
  }
}
