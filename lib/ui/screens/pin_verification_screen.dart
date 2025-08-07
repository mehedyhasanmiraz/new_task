import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_task/ui/screens/login_screen.dart';
import 'package:new_task/ui/screens/register_screen.dart';
import 'package:new_task/ui/screens/reset_password_screen.dart';
import 'package:new_task/ui/widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utills/assets_path.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreen();
}

class _PinVerificationScreen extends State<PinVerificationScreen> {

  final TextEditingController _pinCodeController = TextEditingController();
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
                  SizedBox(height: 80,),
                  Text("Pin Verification", style: TextTheme.of(context).titleLarge),
                  SizedBox(height: 10),
                  Text("A 6 digit verification pin has been sent to your email.",style:Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(height: 20),

                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                    keyboardType: TextInputType.number,
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                     controller: _pinCodeController,
                    appContext: context,
                  ),
                  SizedBox(height: 10),

                  Container(
                    height: 50,
                    child: ElevatedButton(onPressed: _onTapSubmitButton,
                        child: Text("Verify")),
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
      ),
    );
  }
  _onTapSubmitButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
  }

  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (pre)=>false);
  }

  @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  }
}
