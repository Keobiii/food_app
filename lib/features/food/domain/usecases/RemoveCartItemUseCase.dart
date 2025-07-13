import 'package:food_app/features/food/domain/repositories/CartRepository.dart';

class RemoveCartItemUseCase {
  final CartRepository repository;

  RemoveCartItemUseCase(this.repository);

  Future<void> call(String cartId) {
    return repository.removeFromCart(cartId);
  }
}
