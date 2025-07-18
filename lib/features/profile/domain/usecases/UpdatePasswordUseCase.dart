
import 'package:food_app/features/profile/domain/repositories/ProfileRepository.dart';

class UpdatePasswordUseCase {
  final ProfileRepository repository;

  UpdatePasswordUseCase(this.repository);

  Future<void> call(String oldPassword, String newPassword) {
    return repository.changePassword(oldPassword, newPassword);
  }
}