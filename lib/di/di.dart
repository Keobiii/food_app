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
import 'package:food_app/features/food/data/datasources/FoodRemoteDataSource.dart';
import 'package:food_app/features/food/data/datasources/SupabaseFoodDataSource.dart';
import 'package:food_app/features/food/data/repositories/CategoryRepositoryImpl%20.dart';
import 'package:food_app/features/food/data/repositories/FoodRepositoryImpl.dart';
import 'package:food_app/features/food/domain/repositories/CategoryRepository.dart';
import 'package:food_app/features/food/domain/repositories/FoodRepository.dart';
import 'package:food_app/features/food/domain/usecases/GetAllFoodsUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetCategoriesUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetFoodByCategoryUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_bloc.dart';
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

  sl.registerLazySingleton<FoodRemoteDataSource>(
    () => SupabaseFoodDataSource(sl())
  );




  // repository
  sl.registerLazySingleton<Authrepository>(
    () => AuthRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl()
    ));

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl())
  );

  sl.registerLazySingleton<FoodRepository>(
    () => FoodRepositoryImpl(sl())
  );

  // usecase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetFoodByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetAllFoodsUseCase(sl()));

  // bloc
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(), 
    registerUseCase: sl(), 
    logoutUseCase: sl(),
  ));

  sl.registerFactory(() => CategoryBloc(
    getCategoriesUseCase: sl()
  ));

  sl.registerFactory(() => FoodBloc(
    getFoodCategoryUseCase: sl(),
    getAllFoodsUseCase: sl()
  ));
}