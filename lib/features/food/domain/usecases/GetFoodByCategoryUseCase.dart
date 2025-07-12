import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/domain/repositories/FoodRepository.dart';

class GetFoodByCategoryUseCase {
  final FoodRepository repository;

  GetFoodByCategoryUseCase(this.repository);

  Future<List<FoodEntity>> call(String categoryName) {
    return repository.getFoods(categoryName);
  }
}