class CartEntity {
  final String userId;
  final String foodId;
  final int quantity;

  CartEntity({
    required this.userId,
    required this.foodId,
    required this.quantity
  });
}