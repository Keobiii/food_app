import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/widgets/button.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_bloc.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_event.dart';
import 'package:food_app/features/profile/presentation/bloc/bloc_profile/profile_state.dart';
import 'package:food_app/features/profile/presentation/utils/profileAppBar.dart';
import 'package:go_router/go_router.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: const ProfileAppBar(),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              showSnackBar(context, state.message);
              debugPrint("Error: ${state.message}");
            } else if (state is ProfileUpdateSuccess) {
              showSnackBar(context, "Profile updated successfully");
              context.pop();
            } else if (state is ProfileLoaded) {
              // Set values to the text controllers
              final user = state.user;
      
              firstNameController.text = user.firstName;
              lastNameController.text = user.lastName;
              emailController.text = user.email;
      
              debugPrint("User data loaded: ${user.firstName} ${user.lastName} ${user.email}");
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20,),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Details",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        SizedBox(height: 5),
                        Text(
                          "You can update your name anytime, but your email is fixed and can’t be changed for security reasons.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
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
                  
                  
                  Container(
                    width: double.infinity,
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        // if (state is ProfileLoading) {
                        //   return const CircularProgressIndicator();
                        // }
                    
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
                            buttonText:
                                state is ProfileLoading
                                    ? "Loading..."
                                    : "Update",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

