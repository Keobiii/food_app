import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/auth/data/datasources/AuthRemoteDatasource.dart';
import 'package:food_app/features/auth/data/datasources/SupabaseAuthDataSource%20.dart';
import 'package:food_app/features/auth/data/repositories/AuthLocalDataSourceImpl.dart';
import 'package:food_app/features/auth/data/repositories/AuthRepositoryImpl.dart';
import 'package:food_app/features/auth/domain/repositories/AuthRepository.dart';
import 'package:food_app/features/auth/domain/usecases/LoginUseCase.dart';
import 'package:food_app/features/auth/domain/usecases/LogoutUseCase.dart';
import 'package:food_app/features/auth/domain/usecases/RegisterUseCase.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // supabase client
  final supabase = Supabase.instance.client;
  sl.registerLazySingleton<SupabaseClient>(() => supabase);

  // Sharedpreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => SupabaseAuthDataSource(sl()));
  
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl<SharedPreferences>()),
  );


  // repository
  sl.registerLazySingleton<Authrepository>(
    () => AuthRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl()
    ));

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