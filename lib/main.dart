import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/app.dart';
import 'package:food_app/di/di.dart' as di;
import 'package:food_app/core/router/app_router.dart' as router;
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // initialize supabase
  await Supabase.initialize(
    url: "https://srnmwtpdizuzihshgmav.supabase.co", 
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNybm13dHBkaXp1emloc2hnbWF2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIxODc2MDgsImV4cCI6MjA2Nzc2MzYwOH0.jLxL4lgGrM-BVFbgP0YRH8xfzL1lXTqwc8obFWSH570"
  );

  // initialize dependency injection (di)
  await di.init();

  final routerInstance = router.createRouter();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>(),
        ),
      ],
      child: App(router: routerInstance),
    ),
  );
}