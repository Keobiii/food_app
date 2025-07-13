import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/domain/entities/CartWithFoodEntity.dart';
import 'package:food_app/features/food/domain/usecases/AddToCartUseCase.dart';
import 'package:food_app/features/food/domain/usecases/FetchAllUserCartUseCase.dart';
import 'package:food_app/features/food/domain/usecases/RemoveCartItemUseCase.dart';
import 'package:food_app/features/food/domain/usecases/UpdateCartQuantityUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_event.dart';
import 'package:food_app/features/food/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final FetchAllUserCartUseCase fetchAllUserCartUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;

  CartBloc({
    required this.addToCartUseCase,
    required this.fetchAllUserCartUseCase,
    required this.removeCartItemUseCase,
    required this.updateCartQuantityUseCase,
  }) : super(CartInitial()) {
    on<AddToCartRequested>(_onAddToCartRequested);
    on<FetchAllUserCartRequested>(_onFetchAllUserCartRequested);
    on<RemoveCartItemRequested>(_onRemoveCartItemRequested);
    on<IncreaseCartQuantity>(_onIncreaseCartQuantity);
    on<DecreaseCartQuantity>(_onDecreaseCartQuantity);
  }

  Future<void> _onAddToCartRequested(
    AddToCartRequested event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final userCarts = await fetchAllUserCartUseCase(event.cart.userId);
      CartWithFoodEntity? existingItem;
      try {
        existingItem = userCarts.firstWhere(
          (item) => item.cart.foodId == event.cart.foodId,
        );
      } catch (_) {
        existingItem = null;
      }

      if (existingItem != null) {
        await updateCartQuantityUseCase(existingItem.cart.id!, 1);
        emit(CartAddedSucces(existingItem.cart));

        // emit(CartAlreadyExists("Item is already in your cart"));
      } else {
        await addToCartUseCase(event.cart);
        emit(CartAddedSucces(event.cart));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onFetchAllUserCartRequested(
    FetchAllUserCartRequested event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final carts = await fetchAllUserCartUseCase(event.userId);
      emit(CartLoaded(carts));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveCartItemRequested(
    RemoveCartItemRequested event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await removeCartItemUseCase(event.cartId);
      final carts = await fetchAllUserCartUseCase(event.userId);
      emit(CartLoaded(carts));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onIncreaseCartQuantity(
    IncreaseCartQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await updateCartQuantityUseCase(event.cartId, 1);
      add(FetchAllUserCartRequested(event.userId));
    } catch (e) {
      emit(CartError('Failed to increase quantity'));
    }
  }

  Future<void> _onDecreaseCartQuantity(
    DecreaseCartQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      if (event.currentQuantity <= 1) {
        await removeCartItemUseCase(event.cartId);
      } else {
        await updateCartQuantityUseCase(event.cartId, -1);
      }
      add(FetchAllUserCartRequested(event.userId));
    } catch (e) {
      emit(CartError('Failed to decrease quantity'));
    }
  }
}
