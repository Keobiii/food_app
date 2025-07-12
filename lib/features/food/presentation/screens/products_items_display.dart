import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/models/product_model.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';

class ProductsItemsDisplay extends StatefulWidget {
  final FoodEntity foodEntity;
  const ProductsItemsDisplay({super.key, required this.foodEntity});

  @override
  State<ProductsItemsDisplay> createState() => _ProductsItemsDisplayState();
}

class _ProductsItemsDisplayState extends State<ProductsItemsDisplay> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 10,
            child: Container(
              height: 200,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
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

          Container(
            width: size.width * 0.5,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  widget.foodEntity.imageCard,
                  height: 140,
                  width: 150,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
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
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
