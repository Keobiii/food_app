import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
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
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CartError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        if (state is CartLoaded) {
          final cartItems = state.carts;

          return Scaffold(
            appBar: AppBar(title: const Text("My Cart")),
            body: ListView.builder(
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
                            child: Icon(Icons.remove, color: Colors.black),
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
                            child: Icon(Icons.add, color: Colors.black),
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

        return const SizedBox.shrink();
      },
    );
  }
}
