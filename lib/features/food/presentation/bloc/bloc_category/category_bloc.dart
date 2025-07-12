import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/domain/usecases/GetCategoriesUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc({
    required this.getCategoriesUseCase,
  }) : super(CategoryInitial()) {
    on<GetCategoryRequested>(_onCategoryRequested);
  }

  Future<void> _onCategoryRequested(GetCategoryRequested event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await getCategoriesUseCase();
      emit(CategorySuccessResponse(categories));
      
    } catch (e) {
      emit(CategoryFailedResponse(e.toString()));
    }
  }
}