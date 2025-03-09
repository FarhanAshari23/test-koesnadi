import 'dart:convert';

import '../../../domain/entities/auth/user.dart';

class UserModel {
  final String userId;
  final String fullName;
  final String email;
  final String favorite;
  final String birthDate;
  final int gender;

  UserModel({
    required this.userId,
    required this.birthDate,
    required this.email,
    required this.favorite,
    required this.fullName,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': fullName,
      'birth_date': birthDate,
      'gender': gender,
      'favorite': favorite,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      fullName: map['name'],
      email: map['email'] ?? '',
      birthDate: map['birth_date'] ?? '',
      gender: map['gender']?.toInt() ?? 0,
      favorite: map['favorite'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      favorite: favorite,
      birthDate: birthDate,
      gender: gender,
    );
  }
}
