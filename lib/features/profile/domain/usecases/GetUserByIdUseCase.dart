import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:food_app/features/profile/domain/repositories/ProfileRepository.dart';

class GetUserByIdUseCase {
  final ProfileRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<UserEntity> call(String uid) {
    return repository.getUserById(uid);
  }
}