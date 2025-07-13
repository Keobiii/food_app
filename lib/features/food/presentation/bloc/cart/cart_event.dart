import 'package:equatable/equatable.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartRequested  extends CartEvent {
  final CartEntity cart;

  AddToCartRequested(this.cart);

  @override
  List<Object?> get props => [cart];
}

