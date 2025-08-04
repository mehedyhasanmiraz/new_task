import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_task/ui/screens/forgot_password_verify_screen.dart';
import 'package:new_task/ui/screens/register_screen.dart';
import 'package:new_task/ui/widgets/screen_background.dart';

import '../utills/assets_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
          
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Get Started With", style: TextTheme.of(context).titleLarge),
                  SizedBox(height: 10),
                  Text("Login with your email and password",style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email")),
                  SizedBox(height: 10),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                    controller: _passwordTEController,
                      decoration: InputDecoration(hintText: "Password")),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    child: ElevatedButton(onPressed: () {}, child: Text("Submit")),
                  ),
          
                  SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: onTapForgotPassword,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
          
          
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              TextSpan(text: "Sign Up",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapForgotPassword(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerifyScreen()));
  }
  void _onTapSignUpButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
