import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  UserModel({required String id, required String email})
    : super(id: id, email: email);

  factory UserModel.fromSupabase(User user) {
    return UserModel(id: user.id, email: user.email ?? "");
  }
}