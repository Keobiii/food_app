import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/profile/domain/usecases/GetUserByIdUseCase.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_event.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserByIdUseCase getUserByIdUseCase;

  ProfileBloc({
    required this.getUserByIdUseCase,
  }) : super(ProfileInitial()) {
    on<GetUserById>(_onGetUserById);
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
}