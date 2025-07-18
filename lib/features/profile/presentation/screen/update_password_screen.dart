import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/widgets/button.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_bloc.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_event.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_state.dart';
import 'package:go_router/go_router.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  // Controllers
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
      context.read<ProfileBloc>().add(GetUserById(userUid!));
      debugPrint("Cached UID: $userUid");
    } else {
      debugPrint("No user is cached.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            showSnackBar(context, state.message);
          } else if (state is UpdatePasswordFailure) {
            showSnackBar(context, state.message); 
          } else if (state is ProfileUpdateSuccess) {
            showSnackBar(context, "Password updated successfully");
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            context.pop();
          } 
        },
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  labelText: "Current Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const CircularProgressIndicator();
                  }

                  return SizedBox(
                    width: double.infinity,
                    child: Button(
                      onTap: () {
                        String oldPassword = oldPasswordController.text.trim();
                        String newPassword = newPasswordController.text.trim();
                        String confimPassword = confirmPasswordController.text.trim();

                        if (userUid == null) {
                          showSnackBar(context, "Please login to update your password");
                          return;
                        }

                        if (oldPassword.isEmpty ||
                            newPassword.isEmpty ||
                            confimPassword.isEmpty) {
                          showSnackBar(context, "All fields are required");
                          return;
                        }

                        if (newPassword != confimPassword) {
                          showSnackBar(context, "Passwords do not match");
                          return;
                        }

                        context.read<ProfileBloc>().add(
                          UpdatePassword(userUid!, oldPassword, confimPassword),
                        );
                      },
                      buttonText: "Update",
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

