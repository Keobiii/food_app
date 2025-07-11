import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/widgets/button.dart';
import 'package:food_app/core/utils/widgets/snack_bar.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  void _signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = confirmPasswordController.text.trim();

    if (!email.contains(".com")) {
      showSnackBar(context, "Invalid Email");
      return;
    }

    if (password != cpassword) {
      showSnackBar(context, "Password does not matched");
      return;
    }

    // bloc
    context.read<AuthBloc>().add(RegisterRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            
          } else if (state is AuthSuccess) {
            showSnackBar(context, "Signup Successful");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen()
              )
            );
          } else if (state is AuthFailure) {
            showSnackBar(context, "Signup Error: ${state.message}");
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset(
                  "assets/6343825.jpg",
                  width: double.maxFinite,
                  height: 300,
                  fit: BoxFit.cover,
                ),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: isPasswordHidden,
                ),

                SizedBox(height: 20),

                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordHidden = !isConfirmPasswordHidden;
                        });
                      },
                      icon: Icon(
                        isConfirmPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: isConfirmPasswordHidden,
                ),

                SizedBox(height: 20),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: Button(
                        onTap: _signUp, 
                        buttonText: "Signup"
                      ),
                    );
                  },
                ),


                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login here",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
