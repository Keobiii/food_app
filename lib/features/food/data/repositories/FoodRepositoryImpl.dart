import 'package:food_app/features/food/data/datasources/FoodRemoteDataSource.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/domain/repositories/FoodRepository.dart';

class FoodRepositoryImpl implements FoodRepository{
final FoodRemoteDataSource remoteDataSource;

  FoodRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<FoodEntity>> getFoods(String categoryName) async {
    final models = await remoteDataSource.getFoods(categoryName);
    return models.map((model) => FoodEntity(
      id: model.id,
      imageCard: model.imageCard,
      imageDetail: model.imageDetail,
      name: model.name,
      price: model.price,
      rate: model.rate,
      specialItems: model.specialItems,
      category: model.category,
      kcal: model.kcal,
      time: model.time,
    )).toList();
  }


  @override
  Future<List<FoodEntity>> getAllFoods() async {
    final models = await remoteDataSource.getAllFoods();
    return models.map((model) => FoodEntity(
      id: model.id,
      imageCard: model.imageCard,
      imageDetail: model.imageDetail,
      name: model.name,
      price: model.price,
      rate: model.rate,
      specialItems: model.specialItems,
      category: model.category,
      kcal: model.kcal,
      time: model.time,
    )).toList();
  }
  
  @override
  Future<FoodEntity> getFoodById(String id) async {
    final model = await remoteDataSource.getFoodById(id);
    return FoodEntity(
      id: model.id,
      name: model.name,
      price: model.price,
      imageCard: model.imageCard,
      imageDetail: model.imageDetail,
      rate: model.rate,
      kcal: model.kcal,
      time: model.time,
      specialItems: model.specialItems,
      category: model.category,
    );
  }
}