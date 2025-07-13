import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:food_app/features/food/domain/repositories/CartRepository.dart';

class FetchAllUserCartUseCase {
  final CartRepository repository;

  FetchAllUserCartUseCase(this.repository);

  Future<List<CartEntity>> call(String userId) {
    return repository.fetchUserCart(userId);
  }
}