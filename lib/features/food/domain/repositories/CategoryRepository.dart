import 'package:food_app/features/food/domain/entities/CategoryEntity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories();
}