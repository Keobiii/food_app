import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:food_app/features/profile/presentation/utils/ProfileSettingList.dart';
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
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            context.go('/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 280,
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/food-delivery/profile.png", height: 50, width: 50, fit: BoxFit.contain,),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Juan Dela Cruz',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '${userUid}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      SizedBox(height: 20,),

                      ProfileSettingList(
                        imagePath: "assets/food-delivery/burger.png",
                        title: "Profile",
                        subtitle: "View and edit your profile",
                        onTap: () {
                          
                        },
                      ),
                      SizedBox(height: 15,),
                      ProfileSettingList(
                        imagePath: "assets/food-delivery/pizza.png",
                        title: "Orders",
                        subtitle: "View your orders",
                        onTap: () {
                          context.push('/viewAllProduct');
                        },
                      ),
                      SizedBox(height: 15,),
                      ProfileSettingList(
                        imagePath: "assets/food-delivery/cup cake.png",
                        title: "Logout",
                        subtitle: "Logout from your account",
                        onTap: () {
                          context.read<AuthBloc>().add(LogoutRequested());
                        },
                      ),
                      SizedBox(height: 15,),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
