import 'package:food_app/features/food/domain/repositories/CartRepository.dart';

class UpdateCartQuantityUseCase {
  final CartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  Future<void> call(String cartId, int delta) {
    return repository.updateCartQuantity(cartId, delta);
  }
}