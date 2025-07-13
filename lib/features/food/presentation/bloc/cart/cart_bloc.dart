import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/domain/usecases/AddToCartUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_event.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  final AddToCartUseCase addToCartUseCase;

  CartBloc({
    required this.addToCartUseCase
  }) : super(CartInitial()) {
    on<AddToCartRequested>(_onAddToCartRequested);
  }

  Future<void> _onAddToCartRequested(AddToCartRequested event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await addToCartUseCase(event.cart);
      emit(CartAddedSucces(event.cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}