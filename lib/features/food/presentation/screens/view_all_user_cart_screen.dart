import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/widgets/button.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_state.dart';

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
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CartError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        if (state is CartLoaded) {
          final cartItems = state.carts;

          
          final totalAmount = cartItems.fold<double>(
            0.0,
            (sum, item) => sum + (item.food.price * item.cart.quantity),
          );

          return Scaffold(
            appBar: AppBar(title: const Text("My Cart")),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final cart = cartItems[index].cart;
                      final food = cartItems[index].food;

                      return Dismissible(
                        key: Key(cart.id!),
                        onDismissed: (direction) {
                          context.read<CartBloc>().add(
                            RemoveCartItemRequested(cart.id!, userUid!),
                          );
                          showSnackBar(context, "Item removed");
                          context.read<CartBloc>().add(
                            FetchAllUserCartRequested(userUid!),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Image.network(food.imageCard, width: 30),
                            title: Text(food.name),
                            subtitle: Text("₱${food.price}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<CartBloc>().add(
                                      DecreaseCartQuantity(
                                        cartId: cart.id!,
                                        userId: userUid!,
                                        currentQuantity: cart.quantity,
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  cart.quantity.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    context.read<CartBloc>().add(
                                      IncreaseCartQuantity(
                                        cartId: cart.id!,
                                        userId: userUid!,
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 💰 Display total amount here
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₱${totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          onTap: () {
                            context.read<CartBloc>().add(
                              ClearUserCartRequested(userUid!),
                            );
                          },
                          buttonText: "Checkout",
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
