import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/colors/consts.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
import 'package:food_app/features/food/domain/entities/CategoryEntity.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_state.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_state.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_state.dart';
import 'package:food_app/features/food/presentation/screens/products_items_display.dart';
import 'package:go_router/go_router.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  List<CategoryEntity> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoryRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartAddedSucces) {
            showSnackBar(context, "Item Added Successfully");
          } else if (state is CartError) {
            showSnackBar(context, "Item failed to add");
          }
        },
        child: SingleChildScrollView(
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
      ),
    );
  }

  Widget _buildProductSection() {
    return SizedBox(
      height: 300,
      child: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FoodError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is FoodLoaded) {
            final products = state.foodList;

            if (products.isEmpty) {
              return const Center(child: Text("No Products found"));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 25,
                    right: index == products.length - 1 ? 25 : 0,
                  ),
                  child: ProductsItemsDisplay(foodEntity: product),
                );
              },
            );
          }

          return const SizedBox.shrink();
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
            onTap: () {
              context.push('/search');
            },
            child: Text("View All", style: TextStyle(color: Colors.grey[500])),
            
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CategoryFailedResponse) {
          return Center(child: Text("Failed to load categories"));
        }

        if (state is CategorySuccessResponse) {
          final fetchedCategories = state.category;

          if (selectedCategory == null && state.category.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                categories = state.category;
                selectedCategory = state.category.first.name;

                context.read<FoodBloc>().add(
                  FetchFoodByCategory(selectedCategory!),
                );
              });
            });
          }

          return SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fetchedCategories.length,
              itemBuilder: (context, index) {
                final category = fetchedCategories[index];

                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 15 : 0,
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () => handleCategoryTap(category.name),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
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
        }

        return SizedBox.shrink(); 
      },
    );
  }

  void handleCategoryTap(String category) {
    if (selectedCategory == category) return;
    setState(() {
      selectedCategory = category;

      context.read<FoodBloc>().add(FetchFoodByCategory(category));
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
        // SizedBox(width: 25),
        // Container(
        //   height: 45,
        //   width: 45,
        //   padding: EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //     color: grey1,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: Image.asset("assets/food-delivery/icon/dash.png"),
        // ),
        // Spacer(),
        
        SizedBox(width: 25),
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
