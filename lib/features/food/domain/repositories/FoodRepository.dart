import 'package:food_app/features/food/domain/entities/FoodEntity.dart';

abstract class FoodRepository {
  Future<List<FoodEntity>> getFoods(String categoryName);
}