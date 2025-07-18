import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/widgets/button.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_bloc.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_event.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_state.dart';

class UpdateDetailsScreen extends StatefulWidget {
  const UpdateDetailsScreen({super.key});

  @override
  State<UpdateDetailsScreen> createState() => _UpdateDetailsScreenState();
}

class _UpdateDetailsScreenState extends State<UpdateDetailsScreen> {
  // Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            debugPrint("Error: ${state.message}");
          } else if (state is ProfileUpdateSuccess) {
            showSnackBar(context, "Profile updated successfully");
          } else if (state is ProfileLoaded) {
            // Set values to the text controllers
            final user = state.user;

            firstNameController.text = user.firstName;
            lastNameController.text = user.lastName;
            emailController.text = user.email;

            debugPrint("User data loaded: ${user.firstName} ${user.lastName} ${user.email}");
          }
        },
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
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
                        String email = emailController.text.trim();
                        String firstName = firstNameController.text.trim();
                        String lastName = lastNameController.text.trim();

                        if (email.isEmpty ||
                            firstName.isEmpty ||
                            lastName.isEmpty) {
                          showSnackBar(context, "All fields are required");
                          return;
                        }

                        if (!email.contains(".com")) {
                          showSnackBar(context, "Invalid Email");
                          return;
                        }

                        context.read<ProfileBloc>().add(
                          UpdateUserDetails(userUid!, firstName, lastName),
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
