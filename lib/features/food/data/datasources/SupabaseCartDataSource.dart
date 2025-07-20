import 'package:food_app/features/food/data/datasources/CartRemoteDataSource.dart';
import 'package:food_app/features/food/data/models/CartModel.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:postgrest/src/types.dart';
import 'package:postgrest/postgrest.dart';

class SupabaseCartDataSource implements CartRemoveDataSource {
  final SupabaseClient client;

  SupabaseCartDataSource(this.client);

  @override
  Future<void> addToCart(CartModel cartModel) async {
    try {
      final response = await client.from('cart_items').insert(cartModel.toJson());
      print("Inserted cart: $response");
    } catch (error) {
      print("Error adding item to cart: $error");
      throw Exception('Failed to add item to cart: $error');
    }
  }

  @override
  Future<List<CartEntity>> fetchUserCart(String userId) async{
    final response = await client
        .from("cart_items")
        .select()
        .eq("user_id", userId);

    return (response as List<dynamic>)
      .map((json) => CartModel.fromJson(json as Map<String, dynamic>))
      .toList();
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

  @override
  Future<void> updateCartQuantity(String cartId, int delta) async {
    try {
      final fetchResponse = await client
          .from('cart_items')
          .select('quantity')
          .eq('id', cartId)
          .single();

      if (fetchResponse == null || fetchResponse['quantity'] == null) {
        throw Exception('Cart item not found');
      }

      final currentQuantity = fetchResponse['quantity'] as int;
      final newQuantity = currentQuantity + delta;

      final updateResponse = await client
          .from('cart_items')
          .update({'quantity': newQuantity})
          .eq('id', cartId)
          .select();

      if (updateResponse == null || updateResponse.isEmpty) {
        throw Exception('Failed to update quantity');
      }
    } catch (e) {
      throw Exception('Error updating cart quantity: $e');
    }
  }

}