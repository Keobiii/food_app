import 'package:food_app/features/auth/domain/repositories/AuthRepository.dart';

class LogoutUseCase {
  final Authrepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() => repository.logout();
}