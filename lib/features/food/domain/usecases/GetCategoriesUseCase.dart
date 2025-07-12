import 'package:food_app/features/food/domain/entities/CategoryEntity.dart';
import 'package:food_app/features/food/domain/repositories/CategoryRepository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() => repository.getCategories();
}