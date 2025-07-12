import 'package:food_app/features/food/data/datasources/FoodRemoteDataSource.dart';
import 'package:food_app/features/food/domain/entities/CategoryEntity.dart';
import 'package:food_app/features/food/domain/repositories/CategoryRepository.dart';

class CategoryRepositoryImpl implements CategoryRepository  {
  final FoodRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final models = await remoteDataSource.getCategories();
    return models.map((model) => CategoryEntity(
      image: model.image,
      name: model.name,
    )).toList();
  }
}