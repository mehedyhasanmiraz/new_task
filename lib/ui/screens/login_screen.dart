import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_task/ui/widgets/screen_background.dart';

import '../utills/assets_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Get Started With", style: TextTheme.of(context).titleLarge),
              SizedBox(height: 10),
              Text("Login your email and password",style: TextStyle(color: Colors.grey),),
              SizedBox(height: 20),
              TextFormField(decoration: InputDecoration(hintText: "Email")),
              SizedBox(height: 10),
              TextFormField(decoration: InputDecoration(hintText: "Password")),
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
                          TextSpan(text: "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
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
    );
  }

  void onTapForgotPassword(){}
  void _onTapSignInButton(){}
}
