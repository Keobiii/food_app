import 'package:food_app/features/food/domain/entities/CartEntity.dart';

class CartModel extends CartEntity {
  CartModel({
    required String userId,
    required String foodId,
    required int quantity,
  }) : super(userId: userId, foodId: foodId, quantity: quantity);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['user_id'], 
      foodId: json['food_id'], 
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'food_id': foodId,
      'quantity': quantity
    };
  }
}