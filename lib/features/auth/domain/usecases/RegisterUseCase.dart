import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:food_app/features/auth/domain/repositories/AuthRepository.dart';

class RegisterUseCase {
  final Authrepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call(UserEntity user, String password) {
    return repository.register(user, password);
  }
}