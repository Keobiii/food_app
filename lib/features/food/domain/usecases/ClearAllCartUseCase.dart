import 'package:food_app/features/food/domain/repositories/CartRepository.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<void> call(String userId) {
    return repository.clearAllCart(userId);
  }
}