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
    on<SearchFood>(_onSearchFood);
  }

  Future<void> _onGetFoodbyCategory(FetchFoodByCategory event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    try {
      final categoryFoods = await getFoodCategoryUseCase(event.category);
      final allFoods = await getAllFoodsUseCase();
      emit(FoodLoaded(allFoods, categoryFoods));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  Future<void> _onGetAllFood(FetchAllFood event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
    try {
      final allFoods = await getAllFoodsUseCase();
      emit(FoodLoaded(allFoods, allFoods)); 
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

  Future<void> _onSearchFood(SearchFood event, Emitter<FoodState> emit) async {
    final currentState = state;
    if (currentState is FoodLoaded) {
      final filtered = currentState.allFoods.where((food) {
        return food.name.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      emit(FoodLoaded(currentState.allFoods, filtered));
    }
  }
}