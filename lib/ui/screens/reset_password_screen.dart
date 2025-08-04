import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_task/ui/screens/forgot_password_verify_screen.dart';
import 'package:new_task/ui/screens/login_screen.dart';
import 'package:new_task/ui/screens/register_screen.dart';
import 'package:new_task/ui/widgets/screen_background.dart';

import '../utills/assets_path.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {

  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(

          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Reset Password", style: TextTheme.of(context).titleLarge),
                SizedBox(height: 10),
                Text("Minimum 8 length character set letter and number password collaboration",style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 20),
                TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Password")),
                SizedBox(height: 10),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(hintText: "Confirm Password")),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  child: ElevatedButton(onPressed: _onTapSubmitButton,
                      child: Text("Confirm")),
                ),

                SizedBox(height: 40),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTapSubmitButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (pre)=>false,);
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
