import 'package:food_app/features/food/data/datasources/CartRemoteDataSource.dart';
import 'package:food_app/features/food/data/models/CartModel.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCartDataSource implements CartRemoveDataSource {
  final SupabaseClient client;

  SupabaseCartDataSource(this.client);

  @override
  Future<void> addToCart(CartModel cartModel) async {
    try {
      final response = await client.from('cart_items').insert(cartModel.toJson());
      print("Inserted cart: $response");
    } catch (error) {
      throw Exception('Failed to add item to cart: $error');
    }
  }

  @override
  Future<List<CartEntity>> fetchUserCart(String userId) async{
    final response = await client
        .from("cart_items")
        .select()
        .eq("user_id", userId);

    return (response as List).map((json) => CartModel.fromJson(json)).toList();
  }

  @override
  Future<void> removeCartItem(String cartId) async {
    try {
      final response = await client
          .from('cart_items')
          .delete()
          .eq('id', cartId)
          .select();

     
      if (response == null || (response is List && response.isEmpty)) {
        throw Exception('Cart item not found or already deleted');
      }
    } catch (e) {
      throw Exception('Failed to remove item: $e');
    }
  }

}