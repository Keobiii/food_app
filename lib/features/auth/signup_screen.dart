import 'package:flutter/material.dart';
import 'package:food_app/components/widgets/button.dart';
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
                      onPressed: (){}, 
                      icon: Icon(Icons.visibility)
                    )
                  ),
                ),
        
                SizedBox(height: 20),
        
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: (){}, 
                      icon: Icon(Icons.visibility)
                    )
                  ),
                ),
        
                SizedBox(height: 20),
        
                SizedBox(
                  width: double.maxFinite,
                  child: Button(
                    onTap: (){}, 
                    buttonText: "SignUp"
                  ),
                ),
        
                SizedBox(height: 20,),
        
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
                          MaterialPageRoute(
                            builder: (_) => LoginScreen()
                          )
                        );
                      },
                      child: Text(
                        "Login here",
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
