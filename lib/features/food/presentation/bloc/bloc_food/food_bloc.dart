import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/domain/usecases/GetFoodByCategoryUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoodByCategoryUseCase getFoodCategoryUseCase;

  FoodBloc({
    required this.getFoodCategoryUseCase,
  }) : super(FoodInitial()) {
    on<FetchFoodByCategory>(_onGetFoodbyCategory);
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
}