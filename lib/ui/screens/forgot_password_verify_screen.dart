import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_task/ui/screens/pin_verification_screen.dart';
import 'package:new_task/ui/widgets/screen_background.dart';


class ForgotPasswordVerifyScreen extends StatefulWidget {
  const ForgotPasswordVerifyScreen({super.key});

  @override
  State<ForgotPasswordVerifyScreen> createState() => _ForgotPasswordVerifyScreen();
}

class _ForgotPasswordVerifyScreen extends State<ForgotPasswordVerifyScreen> {

  final TextEditingController _emailTEController = TextEditingController();
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
                Text("Your Email Address", style: TextTheme.of(context).titleLarge),
                SizedBox(height: 10),
                Text("A 6 digit verification pin will be sent to your email.",style:Theme.of(context).textTheme.bodyMedium,),
                SizedBox(height: 20),
                TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email")),
                SizedBox(height: 10),

                Container(
                  height: 50,
                  child: ElevatedButton(onPressed: _onTapSubmitButton,
                      child: Text("Submit")),
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen()));
  }

  void _onTapSignInButton(){
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
