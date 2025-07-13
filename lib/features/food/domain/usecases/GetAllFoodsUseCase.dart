import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/domain/repositories/FoodRepository.dart';

class GetAllFoodsUseCase {
  final FoodRepository repository;

  GetAllFoodsUseCase(this.repository);

  Future<List<FoodEntity>> call() {
    return repository.getAllFoods();
  }
}