import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_task/data/models/login_model.dart';
import 'package:new_task/ui/controllers/auth_controller.dart';
import 'package:new_task/ui/screens/forgot_password_verify_screen.dart';
import 'package:new_task/ui/screens/main_bottom_nav.dart';
import 'package:new_task/ui/screens/register_screen.dart';
import 'package:new_task/ui/widgets/screen_background.dart';

import '../../data/service/network_client.dart';
import '../utills/snack_bar_message.dart';
import '../utills/urls.dart';
import '../widgets/circular_progress_indicator.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loginInProgress = false;



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
                  SizedBox(height: 100,),
                  Text("Get Started With", style: TextTheme.of(context).titleLarge),
                  SizedBox(height: 10),
                  Text("Login with your email and password",style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                    validator: (String? value) {
                      String email = value?.trim() ?? "";
                      if (EmailValidator.validate(email) == false) {
                        return "Enter valid Email";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                      textInputAction: TextInputAction.next,
                    controller: _passwordTEController,
                      decoration: InputDecoration(hintText: "Password"),
                    validator: (String? value) {
                      if ((value?.trim().isEmpty ?? true) ||
                          value!.length < 4) {
                        return "Enter valid Password more than 6 character";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Visibility(
                      visible: loginInProgress == false,
                      replacement: CenterCircularProgressIndicator(),
                      child: ElevatedButton(onPressed: _onTapSubmitButton,
                          child: Text("Submit")),
                    ),
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

  void _onTapSubmitButton(){
    if(_formKey.currentState!.validate()){
      loginUser();
    }
  }

  void onTapForgotPassword(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerifyScreen()));
  }
  Future<void> loginUser()async{
    loginInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,

    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    loginInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      // clearTextField();

      LoginModel loginModel = LoginModel.fromJson(response.data!);
      /// TODO: save token to local
      await AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
      /// TODO: Logged in/or not
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen()), (predicate)=>false);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  // void clearTextField(){
  //   _emailTEController.clear();
  //   _passwordTEController.clear();
  // }


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
