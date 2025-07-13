class CartEntity {
  final String? id;
  final String userId;
  final String foodId;
  final int quantity;

  CartEntity({
    this.id,
    required this.userId,
    required this.foodId,
    required this.quantity
  });
}