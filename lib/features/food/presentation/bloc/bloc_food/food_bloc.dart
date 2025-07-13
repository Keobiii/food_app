import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/domain/usecases/GetAllFoodsUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetFoodByCategoryUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetFoodByIdUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoodByCategoryUseCase getFoodCategoryUseCase;
  final GetAllFoodsUseCase getAllFoodsUseCase;
  final GetFoodByIdUseCase getFoodByIdUseCase;

  FoodBloc({
    required this.getFoodCategoryUseCase,
    required this.getAllFoodsUseCase,
    required this.getFoodByIdUseCase
  }) : super(FoodInitial()) {
    on<FetchFoodByCategory>(_onGetFoodbyCategory);
    on<FetchAllFood>(_onGetAllFood);
    on<FetchFoodDetailById>(_onGetFoodDetailById);
  }

  Future<void> _onGetFoodbyCategory(FetchFoodByCategory event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    try {
      final foods = await getFoodCategoryUseCase(event.category);
      emit(FoodLoaded(foods));
      
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  Future<void> _onGetAllFood(FetchAllFood event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    try {
      final foodList = await getAllFoodsUseCase();
      emit(FoodLoaded(foodList));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  Future<void> _onGetFoodDetailById(FetchFoodDetailById event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    try {
      final food = await getFoodByIdUseCase(event.id);
      emit(FoodDetailLoaded(food));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }
}