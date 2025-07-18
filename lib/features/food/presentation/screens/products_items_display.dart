import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_event.dart';
import 'package:go_router/go_router.dart';

class ProductsItemsDisplay extends StatefulWidget {
  final FoodEntity foodEntity;
  const ProductsItemsDisplay({super.key, required this.foodEntity});

  @override
  State<ProductsItemsDisplay> createState() => _ProductsItemsDisplayState();
}

class _ProductsItemsDisplayState extends State<ProductsItemsDisplay> {
  int quantity = 1;

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
      debugPrint("Cached UID: $userUid");
    } else {
      debugPrint("No user is cached.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async{
        await Future.delayed(const Duration(milliseconds: 300));
        context.push('/foodDetails', extra: widget.foodEntity);
      },
      child: SizedBox(
        height: 260,
        width: size.width * 0.5,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 35,
              child: Container(
                height: 170,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      spreadRadius: 10,
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
        
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red[100],
                  child: Image.asset("assets/food-delivery/icon/fire.png", height: 22,),
                ),
              ),
            ),
        
            Positioned(
              top: 0,
              child: Container(
                width: size.width * 0.5,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: widget.foodEntity.imageCard,
                      child: Image.network(
                        widget.foodEntity.imageCard,
                        height: 130,
                        width: 130,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 10),
                      child: Text(
                        widget.foodEntity.name,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      widget.foodEntity.specialItems,
                      style: TextStyle(
                        height: 0.1,
                        letterSpacing: 0.5,
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "\$",
                                  style: TextStyle(fontSize: 14, color: Colors.red),
                                ),
                                TextSpan(
                                  text: "${widget.foodEntity.price}",
                                  style: TextStyle(fontSize: 25, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                                    
                          GestureDetector(
                            onTap: () {
                              if (userUid == null) {
                                showSnackBar(context, "Please Login First");
                              } else {
                                final cart = CartEntity(
                                  userId: userUid!,
                                  foodId: widget.foodEntity.id,
                                  quantity: quantity,
                                );

                              
                                debugPrint("Adding to cart: userId=${userUid!}, foodId=${widget.foodEntity.id}, qty=$quantity");
                                context.read<CartBloc>().add(AddToCartRequested(cart));
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
