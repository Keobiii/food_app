import 'package:equatable/equatable.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartRequested extends CartEvent {
  final CartEntity cart;

  AddToCartRequested(this.cart);

  @override
  List<Object?> get props => [cart];
}

class FetchAllUserCartRequested extends CartEvent {
  final String userId;

  FetchAllUserCartRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}

class RemoveCartItemRequested extends CartEvent {
  final String cartId;
  final String userId;

  RemoveCartItemRequested(this.cartId, this.userId);

  @override
  List<Object?> get props => [cartId, userId];
}

class IncreaseCartQuantity extends CartEvent {
  final String cartId;
  final String userId;

  IncreaseCartQuantity({required this.cartId, required this.userId});
}

class DecreaseCartQuantity extends CartEvent {
  final String cartId;
  final String userId;
  final int currentQuantity;

  DecreaseCartQuantity({
    required this.cartId,
    required this.userId,
    required this.currentQuantity,
  });
}
