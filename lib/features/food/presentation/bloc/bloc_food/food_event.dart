import 'package:equatable/equatable.dart';

abstract class FoodEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchFoodByCategory extends FoodEvent {
  final String category;

  FetchFoodByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class FetchAllFood extends FoodEvent {}

class FetchFoodDetailById extends FoodEvent {
  final String id;
  
  FetchFoodDetailById(this.id);

  @override
  List<Object?> get props => [id];
}