import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/profile/domain/usecases/GetUserByIdUseCase.dart';
import 'package:food_app/features/profile/domain/usecases/UpdatePasswordUseCase.dart';
import 'package:food_app/features/profile/domain/usecases/UpdateUserUseCase.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_event.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;

  ProfileBloc({
    required this.getUserByIdUseCase,
    required this.updateUserUseCase,
    required this.updatePasswordUseCase,
  }) : super(ProfileInitial()) {
    on<GetUserById>(_onGetUserById);
    on<UpdateUserDetails>(_onUpdateUserDetails);
    on<UpdatePassword>(_onUpdatePassword);
  }

  Future<void> _onGetUserById(GetUserById event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = await getUserByIdUseCase(event.uid);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateUserDetails(UpdateUserDetails event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await updateUserUseCase(event.uid, event.firstName, event.lastName);
      emit(ProfileUpdateSuccess());
      final user = await getUserByIdUseCase(event.uid);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  } 

  Future<void> _onUpdatePassword(UpdatePassword event, Emitter<ProfileState> emit) async {
  emit(ProfileLoading());
  try {
    await updatePasswordUseCase(event.oldPassword, event.newPassword);
    emit(ProfileUpdateSuccess());

    final user = await getUserByIdUseCase(event.userId);
    emit(ProfileLoaded(user));
  } catch (e) {
    emit(UpdatePasswordFailure(e.toString()));
  }
} 
}