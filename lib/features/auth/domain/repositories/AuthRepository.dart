import 'package:food_app/features/auth/domain/entities/UserEntity.dart';

abstract class Authrepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(UserEntity user, String password);
  Future<void> logout();
  
}