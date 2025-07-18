import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/app.dart';
import 'package:food_app/di/di.dart' as di;
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_category/category_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_food/food_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize supabase
  await Supabase.initialize(
    url: "https://srnmwtpdizuzihshgmav.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNybm13dHBkaXp1emloc2hnbWF2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIxODc2MDgsImV4cCI6MjA2Nzc2MzYwOH0.jLxL4lgGrM-BVFbgP0YRH8xfzL1lXTqwc8obFWSH570",
  );

  // initialize dependency injection (di)
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<CategoryBloc>()),
        BlocProvider(create: (_) => di.sl<FoodBloc>()),
        BlocProvider(create: (_) => di.sl<CartBloc>())
      ],
      child: App(),
    ),
  );
}
