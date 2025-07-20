import 'package:equatable/equatable.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';

abstract class FoodState extends Equatable{
  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodEntity> allFoods;
  final List<FoodEntity> foodList;

  FoodLoaded(this.allFoods, this.foodList);

  @override
  List<Object?> get props => [allFoods, foodList];
}

class FoodError extends FoodState {
  final String message;

  FoodError(this.message);

  @override
  List<Object?> get props => [message];
}

class FoodDetailLoaded extends FoodState {
  final FoodEntity foodEntity;

  FoodDetailLoaded(this.foodEntity);

  @override
  List<Object?> get props => [foodEntity];
}