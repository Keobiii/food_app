import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
        );

  // From Supabase Auth User
  factory UserModel.fromSupabase(User user) {
    final fullName = user.userMetadata?['full_name'] ?? "";
    final parts = fullName.split(' ');
    final firstName = parts.isNotEmpty ? parts.first : '';
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      firstName: firstName,
      lastName: lastName,
    );
  }

  // From Supabase DB 'users' table
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }

  // Optional: To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}

