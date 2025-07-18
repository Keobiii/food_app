import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserById extends ProfileEvent {
  final String uid;
  
  GetUserById(this.uid);

  @override
  List<Object?> get props => [uid];
}

class UpdateUserDetails extends ProfileEvent {
  final String uid;
  final String firstName;
  final String lastName;

  UpdateUserDetails(this.uid, this.firstName, this.lastName);

  @override
  List<Object?> get props => [uid, firstName, lastName];
}