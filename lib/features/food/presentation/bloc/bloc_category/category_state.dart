import 'package:equatable/equatable.dart';
import 'package:food_app/features/food/domain/entities/CategoryEntity.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccessResponse extends CategoryState {
  final List<CategoryEntity> category;

  CategorySuccessResponse(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryFailedResponse extends CategoryState {
  final String message;

  CategoryFailedResponse(this.message);

  @override
  List<Object?> get props => [message];
}