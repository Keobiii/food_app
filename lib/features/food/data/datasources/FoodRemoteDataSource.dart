import 'package:food_app/features/food/data/models/CategoryModel.dart';
import 'package:food_app/features/food/data/models/FoodModel.dart';

abstract class FoodRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<FoodModel>> getFoods(String categoryName);
  Future<List<FoodModel>> getAllFoods();
}