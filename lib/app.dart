import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen()
    );
  }
}