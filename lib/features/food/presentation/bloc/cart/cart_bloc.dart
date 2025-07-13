import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/domain/usecases/AddToCartUseCase.dart';
import 'package:food_app/features/food/domain/usecases/FetchAllUserCartUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_event.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  final AddToCartUseCase addToCartUseCase;
  final FetchAllUserCartUseCase fetchAllUserCartUseCase;

  CartBloc({
    required this.addToCartUseCase,
    required this.fetchAllUserCartUseCase
  }) : super(CartInitial()) {
    on<AddToCartRequested>(_onAddToCartRequested);
    on<FetchAllUserCartRequested>(_onFetchAllUserCartRequested);
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

  Future<void> _onFetchAllUserCartRequested(FetchAllUserCartRequested event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final carts = await fetchAllUserCartUseCase(event.userId);
      emit(CartLoaded(carts));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}