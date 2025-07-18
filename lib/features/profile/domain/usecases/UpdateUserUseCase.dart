import 'package:food_app/features/profile/domain/repositories/ProfileRepository.dart';

class UpdateUserUseCase {
  final ProfileRepository repository;

  UpdateUserUseCase(this.repository);

  Future<void> call(String uid, String firstName, String lastName) {
    return repository.updateProfile(uid, firstName, lastName);
  }
}