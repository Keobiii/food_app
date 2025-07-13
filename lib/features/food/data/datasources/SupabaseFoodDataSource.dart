import 'package:food_app/features/food/data/datasources/FoodRemoteDataSource.dart';
import 'package:food_app/features/food/data/models/CategoryModel.dart';
import 'package:food_app/features/food/data/models/FoodModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFoodDataSource implements FoodRemoteDataSource {
  final SupabaseClient client;

  SupabaseFoodDataSource(this.client);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client.from("category_items").select();

    return (response as List).map((json) => CategoryModel.fromJson(json)).toList();

  }

  @override
  Future<List<FoodModel>> getFoods(String categoryName) async {
    final response = await client
        .from("food_product")
        .select()
        .eq("category", categoryName);

    return (response as List).map((json) => FoodModel.fromJson(json)).toList();
  }

  @override
  Future<List<FoodModel>> getAllFoods() async {
    final response = await client
        .from("food_product")
        .select();
    
    return (response as List).map((json) => FoodModel.fromJson(json)).toList();
  }

  Future<FoodModel> getFoodById(String id) async {
    final response = await client
        .from('food_product')
        .select()
        .eq('id', id)
        .single(); // ensures you get only one result

    return FoodModel.fromJson(response);
  }
}