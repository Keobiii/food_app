import 'package:food_app/features/food/data/datasources/CartRemoteDataSource.dart';
import 'package:food_app/features/food/data/models/CartModel.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:food_app/features/food/domain/entities/CartWithFoodEntity.dart';
import 'package:food_app/features/food/domain/repositories/CartRepository.dart';
import 'package:food_app/features/food/domain/repositories/FoodRepository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoveDataSource removeDataSource;
  final FoodRepository foodRepository;

  CartRepositoryImpl(this.removeDataSource, this.foodRepository);

  @override
  Future<void> addToCart(CartEntity cart) async {
    final cartModel = CartModel(
      id: cart.id,
      userId: cart.userId,
      foodId: cart.foodId,
      quantity: cart.quantity,
    );

    await removeDataSource.addToCart(cartModel);
  }
  
  @override
  Future<List<CartWithFoodEntity>> fetchUserCartWithFood(String userId) async {
    final carts = await removeDataSource.fetchUserCart(userId);

    final cartWithFoods = await Future.wait(
      carts.map((cart) async {
        final food = await foodRepository.getFoodById(cart.foodId);
        return CartWithFoodEntity(cart: cart, food: food);
      }).toList(),
    );

    return cartWithFoods;
  }

  @override
  Future<void> removeFromCart(String cartId) async {
    await removeDataSource.removeCartItem(cartId);
  }

  @override
  Future<void> updateCartQuantity(String cartId, int delta) {
    return removeDataSource.updateCartQuantity(cartId, delta);
  }

  @override
  Future<void> clearAllCart(String userId) async {
    final carts = await removeDataSource.fetchUserCart(userId);
    for (final item in carts) {
      await removeDataSource.removeCartItem(item.id!);
    }
  }
  
}
