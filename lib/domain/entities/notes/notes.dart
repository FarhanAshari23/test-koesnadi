import 'package:cloud_firestore/cloud_firestore.dart';

class NotesEntity {
  final String title;
  final String content;
  final Timestamp createdAt;
  String? code;

  NotesEntity({
    required this.title,
    required this.content,
    required this.createdAt,
    this.code,
  });
}
