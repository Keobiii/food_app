import 'package:food_app/core/models/UserModel.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUserById(String uid);
  Future<void> updateProfile(String userId, String firstName, String lastName);
  Future<void> changePassword(String oldPassword, String newPassword);
  // Future<void> deleteAccount(String userId);
}