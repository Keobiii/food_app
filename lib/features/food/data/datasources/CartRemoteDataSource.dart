import 'package:food_app/features/food/data/models/CartModel.dart';

abstract class CartRemoveDataSource {
  Future<void> addToCart(CartModel cartModel);
}