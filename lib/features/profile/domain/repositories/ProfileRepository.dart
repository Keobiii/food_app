import 'package:food_app/features/auth/domain/entities/UserEntity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserById(String uid);
  Future<void> updateProfile(String userId, String firstName, String lastName);
}