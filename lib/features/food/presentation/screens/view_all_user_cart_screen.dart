import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_event.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_state.dart';

class ViewAllUserCartScreen extends StatefulWidget {
  const ViewAllUserCartScreen({super.key});

  @override
  State<ViewAllUserCartScreen> createState() => _ViewAllUserCartScreenState();
}

class _ViewAllUserCartScreenState extends State<ViewAllUserCartScreen> {
  String? userUid;

  @override
  void initState() {
    super.initState();
    checkUserId();
  }

  void checkUserId() async {
    final uid = await sl<AuthLocalDatasource>().getCachedUserId();

    setState(() {
      userUid = uid;
    });

    if (userUid != null) {
      context.read<CartBloc>().add(FetchAllUserCartRequested(uid!));
      debugPrint("Cached UID: $userUid");
    } else {
      debugPrint("No user is cached.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (state is CartError) {
            return Center(child: Text("Error: ${state.message}"),);
          }

          if (state is CartLoaded) {
            final carts = state.carts;
            

            if (carts.isEmpty) {
              return const Center(child: Text("No Products found"),);
            }

            return Scaffold(
              appBar: AppBar(title: const Text("My Cart")),
              body: ListView.builder(
                itemCount: carts.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final cart = carts[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.fastfood, size: 30, color: Colors.red),
                      title: Text("Food ID: ${cart.foodId}"),
                      subtitle: Text("Quantity: ${cart.quantity}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey[700]),
                        onPressed: () {
                          // TODO: Add delete functionality
                        },
                      ),
                    ),
                  );
                },
              ),
            );

          }
      
        return const SizedBox.shrink();
      },
    );
  }
}
