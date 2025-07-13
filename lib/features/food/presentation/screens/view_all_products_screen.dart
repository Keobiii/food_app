import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_state.dart';
import 'package:food_app/features/food/presentation/screens/products_items_display.dart';

class ViewAllProductsScreen extends StatefulWidget {
  const ViewAllProductsScreen({super.key});

  @override
  State<ViewAllProductsScreen> createState() => _ViewAllProductsScreenState();
}

class _ViewAllProductsScreenState extends State<ViewAllProductsScreen> {
  List<FoodEntity> products = [];

  @override
  void initState() {
    context.read<FoodBloc>().add(FetchAllFood());
    super.initState();
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
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (state is FoodError) {
            return Center(child: Text("Error: ${state.message}"),);
          }

          if (state is FoodLoaded) {
            final products = state.foodList;

            if (products.isEmpty) {
              return const Center(child: Text("No Products found"),);
            }

            return  GridView.builder(
                itemCount: products.length,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.57,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return ProductsItemsDisplay(foodEntity: products[index]);
                },
              );
          }

          return const SizedBox.shrink();
        }
        
      )
    );
  }
}
