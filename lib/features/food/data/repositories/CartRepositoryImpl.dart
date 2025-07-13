import 'package:food_app/features/food/data/datasources/CartRemoteDataSource.dart';
import 'package:food_app/features/food/data/models/CartModel.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:food_app/features/food/domain/repositories/CartRepository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoveDataSource removeDataSource;

  CartRepositoryImpl(this.removeDataSource);

  @override
  Future<void> addToCart(CartEntity cart) async {
    final cartModel = CartModel(
      userId: cart.userId,
      foodId: cart.foodId,
      quantity: cart.quantity,
    );

    await removeDataSource.addToCart(cartModel);
  }
}
