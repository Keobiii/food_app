import 'package:food_app/features/food/domain/entities/CartEntity.dart';

class CartModel extends CartEntity {
  CartModel({
    String? id,
    required String userId,
    required String foodId,
    required int quantity,
  }) : super(id: id, userId: userId, foodId: foodId, quantity: quantity);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['user_id'], 
      foodId: json['food_id'], 
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'user_id': userId,
      'food_id': foodId,
      'quantity': quantity,
    };
    if (id != null) map['id'] = id!;
    return map;
  }
}