// data/models/user_model.dart

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name'], email: json['email']);
  }

  User toEntity() {
    return User(id: id, name: name, email: email);
  }
}
