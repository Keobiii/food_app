import 'package:food_app/features/food/data/datasources/CartRemoteDataSource.dart';
import 'package:food_app/features/food/data/models/CartModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCartDataSource implements CartRemoveDataSource {
  final SupabaseClient client;

  SupabaseCartDataSource(this.client);

  @override
  Future<void> addToCart(CartModel cartModel) async {
    try {
      await client.from('cart_items').insert(cartModel.toJson());
    } catch (error) {
      throw Exception('Failed to add item to cart: $error');
    }
  }

}