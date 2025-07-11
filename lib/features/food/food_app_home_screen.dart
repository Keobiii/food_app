import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/core/models/categories_model.dart';
import 'package:food_app/core/models/product_model.dart';
import 'package:food_app/core/utils/colors/consts.dart';
import 'package:food_app/features/food/products_items_display.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  final String CATEGORY_TABLE = "category_items";
  final String FOOD_PRODUCT_DB = "food_product";
  late Future<List<CategoryModel>> fututeCategories = fetchCategories();
  late Future<List<FoodModel>> fututeFoodProducts = Future.value([]);
  List<CategoryModel> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      final categories = await fututeCategories;
      if (categories.isNotEmpty) {
        setState(() {
          this.categories = categories;
          selectedCategory = categories.first.name;

          fututeFoodProducts = fetchFoodProduct(selectedCategory!);
        });
      }
    } catch (e) {
      print("Initialize Error: $e");
    }
  }

  // fetch category from supabase
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response =
          await Supabase.instance.client.from(CATEGORY_TABLE).select();

      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  // fetch products
  Future<List<FoodModel>> fetchFoodProduct(String category) async {
    try {
      final response =
          await Supabase.instance.client.from(FOOD_PRODUCT_DB).select().eq("category", category);

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      print("Error fetching food product: $e");
      return [];
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _appBanner(),
                  SizedBox(height: 25),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildCategoryList(),
            SizedBox(height: 30),
            _viewAll(),
            SizedBox(height: 30),
            _buildProductSection(),
          ],
        ),
      ),
    );
  }


  Widget _buildProductSection() {
    return SizedBox(
      height: 300, 
      child: FutureBuilder<List<FoodModel>>(
        future: fututeFoodProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return Center(child: Text("No Products found"));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: EdgeInsets.symmetric(horizontal: 25),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: index == products.length - 1 ? 25 : 0
                ),
                child: ProductsItemsDisplay(foodModel: products[index]),
              );
            },
          );
        },
      ),
    );
  }


  Padding _viewAll() {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Now",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Text("View All", style: TextStyle(color: Colors.orange)),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }

  Widget _buildCategoryList() {
    return FutureBuilder(
      future: fututeCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox.shrink();
        }

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                child: GestureDetector(
                  onTap: () => handleCategoryTap(category.name),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          selectedCategory == category.name
                              ? Colors.red
                              : grey1,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                selectedCategory == category.name
                                    ? Colors.white
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            category.image,
                            width: 20,
                            height: 20,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.fastfood),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          category.name,
                          style: TextStyle(
                            color:
                                selectedCategory == category.name
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void handleCategoryTap(String category) {
    if (selectedCategory == category) return;
    setState(() {
      selectedCategory = category;

      fututeFoodProducts = fetchFoodProduct(category);
    });
  }

  Container _appBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: imageBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(top: 25, right: 25, left: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: "The fastet In Delivery",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Food",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  child: Text(
                    "Order Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Image.asset("assets/food-delivery/courier.png"),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        SizedBox(width: 25),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset("assets/food-delivery/icon/dash.png"),
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 18, color: Colors.red),
            SizedBox(width: 5),
            Text(
              "Pasig City",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Colors.orange,
            ),
          ],
        ),
        Spacer(),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: grey1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset("assets/food-delivery/profile.png"),
        ),
        SizedBox(width: 25),
      ],
    );
  }
}
