import 'package:flutter/material.dart';
import 'package:food_app/components/widgets/button.dart';
import 'package:food_app/components/widgets/snack_bar.dart';
import 'package:food_app/core/service/auth_service.dart';
import 'package:food_app/features/auth/login_screen.dart';

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

  // Loading
  bool isLoading = false;

  // Services
  final AuthService _authService = AuthService();

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

    setState(() {
      isLoading = !isLoading;
    });

    final result = await _authService.signup(email, password);
    if (result == null) {
      setState(() {
        isLoading = !isLoading;
      });
      showSnackBar(context, "Signup Successful");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      setState(() {
        isLoading = !isLoading;
      });
      showSnackBar(context, "Signup Error: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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

              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                    width: double.maxFinite,
                    child: Button(onTap: _signUp, buttonText: "SignUp"),
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
    );
  }
}
