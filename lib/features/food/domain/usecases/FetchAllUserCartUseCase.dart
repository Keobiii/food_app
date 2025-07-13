import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:food_app/features/food/domain/entities/CartWithFoodEntity.dart';
import 'package:food_app/features/food/domain/repositories/CartRepository.dart';

class FetchAllUserCartUseCase {
  final CartRepository repository;

  FetchAllUserCartUseCase(this.repository);

  Future<List<CartWithFoodEntity>> call(String userId) {
    return repository.fetchUserCartWithFood(userId);
  }
}