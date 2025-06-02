// data/models/user_model.dart

import '../../domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromSupabaseUser(supabase.User user) {
    return UserModel(
      id: int.tryParse(user.id) ?? 0,
      name: user.userMetadata?['name'] ?? '',
      email: user.email ?? '',
    );
  }

  User toEntity() {
    return User(id: id, name: name, email: email);
  }
}
