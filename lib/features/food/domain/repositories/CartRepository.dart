import 'package:food_app/features/food/domain/entities/CartEntity.dart';

abstract class CartRepository {
  Future<void> addToCart(CartEntity cart);
  Future<List<CartEntity>> fetchUserCart(String userId);
}