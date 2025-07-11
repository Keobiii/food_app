import 'package:food_app/features/auth/domain/entities/UserEntity.dart';

abstract class Authrepository {
  Future<Userentity> login(String email, String password);
  Future<Userentity> register(String email, String password);
  Future<void> logout();
  
}