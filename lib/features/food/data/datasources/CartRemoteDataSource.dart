import 'package:food_app/features/food/data/models/CartModel.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';

abstract class CartRemoveDataSource {
  Future<void> addToCart(CartModel cartModel);
  Future<List<CartEntity>> fetchUserCart(String userId);
  Future<void> removeCartItem(String cartId); //
}