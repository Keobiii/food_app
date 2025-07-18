import 'package:food_app/core/models/UserModel.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUserById(String uid);
  // Future<void> updateProfile(String userId, String name, String email);
  // Future<void> changePassword(String userId, String oldPassword, String newPassword);
  // Future<void> deleteAccount(String userId);
}