import 'package:food_app/features/auth/data/datasources/AuthRemoteDatasource.dart';
import 'package:food_app/features/auth/data/datasources/SupabaseAuthDataSource%20.dart';
import 'package:food_app/features/auth/data/repositories/AuthRepositoryImpl.dart';
import 'package:food_app/features/auth/domain/repositories/AuthRepository.dart';
import 'package:food_app/features/auth/domain/usecases/LoginUseCase.dart';
import 'package:food_app/features/auth/domain/usecases/LogoutUseCase.dart';
import 'package:food_app/features/auth/domain/usecases/RegisterUseCase.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // supabase client
  final supabase = Supabase.instance.client;
  sl.registerLazySingleton<SupabaseClient>(() => supabase);

  // data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => SupabaseAuthDataSource(sl()));

  // repository
  sl.registerLazySingleton<Authrepository>(
    () => AuthRepositoryImpl(sl()));

  // usecase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // bloc
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(), 
    registerUseCase: sl(), 
    logoutUseCase: sl(),
  ));
}