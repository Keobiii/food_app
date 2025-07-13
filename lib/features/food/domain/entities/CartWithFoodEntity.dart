import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';

class CartWithFoodEntity {
  final CartEntity cart;
  final FoodEntity food;

  CartWithFoodEntity({required this.cart, required this.food});
}