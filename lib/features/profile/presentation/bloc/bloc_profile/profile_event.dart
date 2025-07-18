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