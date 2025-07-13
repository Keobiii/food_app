import 'package:equatable/equatable.dart';
import 'package:food_app/features/food/domain/entities/CartEntity.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartAddedSucces extends CartState {
  final CartEntity cartEntity;

  CartAddedSucces(this.cartEntity);

  @override
  List<Object?> get props => [cartEntity];
}

class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartLoaded extends CartState {
  final List<CartEntity> carts;

  CartLoaded(this.carts);

  @override
  List<Object?> get props => [carts];
}