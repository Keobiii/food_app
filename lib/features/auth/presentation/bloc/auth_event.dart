import 'package:equatable/equatable.dart';
import 'package:food_app/features/auth/domain/entities/UserEntity.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final UserEntity user;
  final String password;

  RegisterRequested(this.user, this.password);

  @override
  List<Object?> get props => [user, password];
}

class LogoutRequested extends AuthEvent {}