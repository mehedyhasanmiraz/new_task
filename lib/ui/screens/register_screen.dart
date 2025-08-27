import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_task/data/service/network_client.dart';
import 'package:new_task/ui/utills/snack_bar_message.dart';
import 'package:new_task/ui/utills/urls.dart';
import 'package:new_task/ui/widgets/circular_progress_indicator.dart';
import 'package:new_task/ui/widgets/screen_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool registrationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80,),
                  Text("Join With Us", style: TextTheme.of(context).titleLarge),
                  SizedBox(height: 10),
                  Text(
                    "Login with your name, phone number, email and password",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter valid First Name";
                      }
                      return null;
                    },
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "First Name"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Last Name"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter valid Last name";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneNumberTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: "Phone Number"),
                    validator: (String? value) {
                      String phone = value?.trim() ?? "";
                      RegExp regExp = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');
                      if (regExp.hasMatch(phone) == false) {
                        return "Enter valid Phone number";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,

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
                  Container(
                    height: 50,
                    child: Visibility(
                      visible: registrationInProgress == false,
                      replacement: CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Text("Submit"),
                      ),
                    ),
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
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignIpButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      return _registerUser();
    }
  }

  void _registerUser() async {
    registrationInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneNumberTEController.text.trim(), // ✅ fixed
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );

    registrationInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      clearTextField();
      ShowSnackBarMessage(context, "Registration Successfully");
    } else {
      ShowSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void clearTextField(){
    _emailTEController.clear();
    _passwordTEController.clear();
    _phoneNumberTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
  }

  void _onTapSignIpButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _phoneNumberTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
