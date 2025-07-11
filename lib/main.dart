import 'package:flutter/material.dart';
import 'package:food_app/features/auth/login_screen.dart';
import 'package:food_app/features/auth/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: "https://srnmwtpdizuzihshgmav.supabase.co", anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNybm13dHBkaXp1emloc2hnbWF2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIxODc2MDgsImV4cCI6MjA2Nzc2MzYwOH0.jLxL4lgGrM-BVFbgP0YRH8xfzL1lXTqwc8obFWSH570");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen()
    );
  }
}
