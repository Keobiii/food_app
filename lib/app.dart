import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/home/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthCheck()
    );
  }
}

class AuthCheck extends StatelessWidget {
  final supabase = sl<SupabaseClient>();
  AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? supabase.auth.currentSession;
        if (session != null) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}