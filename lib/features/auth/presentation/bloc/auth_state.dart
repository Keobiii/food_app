import 'package:equatable/equatable.dart';
import 'package:food_app/features/auth/domain/entities/UserEntity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}