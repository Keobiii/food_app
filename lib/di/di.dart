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
import 'package:food_app/features/food/data/datasources/CartRemoteDataSource.dart';
import 'package:food_app/features/food/data/datasources/FoodRemoteDataSource.dart';
import 'package:food_app/features/food/data/datasources/SupabaseCartDataSource.dart';
import 'package:food_app/features/food/data/datasources/SupabaseFoodDataSource.dart';
import 'package:food_app/features/food/data/repositories/CartRepositoryImpl.dart';
import 'package:food_app/features/food/data/repositories/CategoryRepositoryImpl%20.dart';
import 'package:food_app/features/food/data/repositories/FoodRepositoryImpl.dart';
import 'package:food_app/features/food/domain/repositories/CartRepository.dart';
import 'package:food_app/features/food/domain/repositories/CategoryRepository.dart';
import 'package:food_app/features/food/domain/repositories/FoodRepository.dart';
import 'package:food_app/features/food/domain/usecases/AddToCartUseCase.dart';
import 'package:food_app/features/food/domain/usecases/FetchAllUserCartUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetAllFoodsUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetCategoriesUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetFoodByCategoryUseCase.dart';
import 'package:food_app/features/food/domain/usecases/GetFoodByIdUseCase.dart';
import 'package:food_app/features/food/domain/usecases/RemoveCartItemUseCase.dart';
import 'package:food_app/features/food/domain/usecases/UpdateCartQuantityUseCase.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:food_app/features/profile/data/datasources/ProfileRemoteDatasource.dart';
import 'package:food_app/features/profile/data/datasources/SupabaseProfileDataSource.dart';
import 'package:food_app/features/profile/data/repositories/ProfileRepositoryImpl.dart';
import 'package:food_app/features/profile/domain/repositories/ProfileRepository.dart';
import 'package:food_app/features/profile/domain/usecases/GetUserByIdUseCase.dart';
import 'package:food_app/features/profile/domain/usecases/UpdateUserUseCase.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_bloc.dart';
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

  sl.registerLazySingleton<CartRemoveDataSource>(
    () => SupabaseCartDataSource(sl())
  );
  
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => SupabaseProfileDataSource(sl())
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

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      sl(),
      sl(), 
    ),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );




  // usecase

  // auth usecase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // category usecase
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetFoodByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetAllFoodsUseCase(sl()));

  // food usecase
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => FetchAllUserCartUseCase(sl()));
  sl.registerLazySingleton(() => GetFoodByIdUseCase(sl()));
  sl.registerLazySingleton(() => RemoveCartItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl()));

  // profile usecase
  sl.registerLazySingleton(() => GetUserByIdUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));


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
    getAllFoodsUseCase: sl(), 
    getFoodByIdUseCase: sl()
  ));

  sl.registerFactory(() => CartBloc(
    addToCartUseCase: sl(), 
    fetchAllUserCartUseCase: sl(),
    removeCartItemUseCase: sl(), 
    updateCartQuantityUseCase: sl()
  ));

  sl.registerFactory(() => ProfileBloc(
    getUserByIdUseCase: sl(),
    updateUserUseCase: sl()
  ));
}