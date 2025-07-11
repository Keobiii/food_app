import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:food_app/features/auth/domain/repositories/AuthRepository.dart';

class LoginUseCase {
  final Authrepository repository;

  LoginUseCase(this.repository);

  Future<Userentity> call(String email, String password) {
    return repository.login(email, password);
  }
}