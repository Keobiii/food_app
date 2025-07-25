import 'package:equatable/equatable.dart';
import 'package:food_app/features/auth/domain/entities/UserEntity.dart';

abstract class ProfileState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdateSuccess extends ProfileState {
}

class UpdatePasswordFailure extends ProfileState {
  final String message;
  UpdatePasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}
