import 'package:flutter/material.dart';
import 'package:food_app/components/widgets/button.dart';
import 'package:food_app/components/widgets/snack_bar.dart';
import 'package:food_app/core/service/auth_service.dart';
import 'package:food_app/features/auth/signup_screen.dart';
import 'package:food_app/features/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  // Loading
  bool isLoading = false;

  // Services
  final AuthService _authService = AuthService();

  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!mounted) return;

    if (!email.contains(".com")) {
      showSnackBar(context, "Invalid Email");
      return;
    }


    setState(() {
      isLoading = !isLoading;
    });

    final result = await _authService.login(email, password);
    if (result == null) {
      setState(() {
        isLoading = !isLoading;
      });
      showSnackBar(context, "Login Successful");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      setState(() {
        isLoading = !isLoading;
      });
      showSnackBar(context, "Login Error: $result");
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
                  "assets/login.jpg",
                  width: double.maxFinite,
                  height: 300,
                  fit: BoxFit.cover,
                ),
        
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder()
                  ),
                ),
        
                SizedBox(height: 20,),
        
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
                      icon: 
                        isPasswordHidden
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility)
                    )
                  ),
                ),
        
                SizedBox(height: 20),

                isLoading
                  ? Center(child: CircularProgressIndicator(),)
                  : SizedBox(
                  width: double.maxFinite,
                  child: Button(
                    onTap: _login, 
                    buttonText: "Login"
                  ),
                ),
                
        
                SizedBox(height: 20,),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignupScreen()
                          )
                        );
                      },
                      child: Text(
                        "Signup here",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: -1
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
