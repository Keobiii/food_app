import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/domain/repositories/FoodRepository.dart';

class GetFoodByIdUseCase {
  final FoodRepository repository;

  GetFoodByIdUseCase(this.repository);

  Future<FoodEntity> call(String id) {
    return repository.getFoodById(id);
  }
}