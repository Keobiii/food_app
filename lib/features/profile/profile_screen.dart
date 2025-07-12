import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userUid;

  @override
  void initState() {
    super.initState();
    checkUserId();
  }

  void checkUserId() async {
    final uid = await sl<AuthLocalDatasource>().getCachedUserId();

    setState(() {
      userUid = uid;
    });

    if (userUid != null) {
      debugPrint("Cached UID: $userUid");
    } else {
      debugPrint("No user is cached.");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            context.go('/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${userUid}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30,),
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
