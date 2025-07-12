import 'package:flutter/material.dart';
import 'package:food_app/core/models/product_model.dart';
import 'package:food_app/features/food/presentation/screens/ProductsItemsDisplay2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewAllProductsScreen extends StatefulWidget {
  const ViewAllProductsScreen({super.key});

  @override
  State<ViewAllProductsScreen> createState() => _ViewAllProductsScreenState();
}

class _ViewAllProductsScreenState extends State<ViewAllProductsScreen> {
  final supabase = Supabase.instance.client;
  List<FoodModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchFoodProduct();
    super.initState();
  }

  Future<void> fetchFoodProduct() async {
    try {
      final response =
          await Supabase.instance.client.from("food_product").select();
      final data = response as List;

      setState(() {
        products = data.map((json) => FoodModel.fromJson(json)).toList();
      });

      isLoading = false;
    } catch (e) {
      print("Error fetching all products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("All Products"),
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                itemCount: products.length,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.57,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return ProductsItemsDisplay2(foodEntity: products[index]);
                },
              ),
    );
  }
}
