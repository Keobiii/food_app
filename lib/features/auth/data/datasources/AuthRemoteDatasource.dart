import 'package:food_app/core/models/UserModel.dart';
import 'package:food_app/features/auth/domain/entities/UserEntity.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserEntity user, String password);
  Future<void> logout();
}