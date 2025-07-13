import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:food_app/features/food/domain/entities/CartWithFoodEntity.dart';

abstract class CartRepository {
  Future<void> addToCart(CartEntity cart);
  Future<void> removeFromCart(String cartId); 
  Future<List<CartWithFoodEntity>> fetchUserCartWithFood(String userId);
  Future<void> updateCartQuantity(String cartId, int delta);
}