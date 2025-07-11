import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (_) => LoginScreen(),
              )
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                }, 
                child: Icon(
                  Icons.exit_to_app
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
