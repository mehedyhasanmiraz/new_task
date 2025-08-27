import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_task/data/models/user_model.dart';
import 'package:new_task/ui/controllers/auth_controller.dart';
import 'package:new_task/ui/widgets/screen_background.dart';
import 'package:new_task/ui/widgets/tm_appbar.dart';

import '../../data/service/network_client.dart';
import '../utills/snack_bar_message.dart';
import '../utills/urls.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateProfileInProgress = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();

    UserModel userModel = AuthController.userModel!;
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _phoneNumberTEController.text = userModel.mobile;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(fromProfileScreen: true),
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
                  SizedBox(height: 30),
                  Text("Profile update", style: TextTheme.of(context).titleLarge),
                  SizedBox(height: 24),
                  buildPhotoPickerWidget(),

                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    enabled: false,
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
                    obscureText: true,
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Password"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Visibility(
                      visible: _updateProfileInProgress == false,
                      replacement: Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Text("Submit"),
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

  Widget buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text("Photo",style: TextStyle(color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(_pickedImage?.name ?? "Select your Photo"),
                      )
                    ],
                  ),
                ),
    );
  }

  void _onTapSubmitButton() {
    if(_formKey.currentState!.validate()){
      /// update profile
      _updateProfile();
    }
  }

  Future<void> _onTapPhotoPicker() async {
    XFile? image = await  _imagePicker.pickImage(source: ImageSource.gallery);

    if(image != null){
       _pickedImage = image;
       setState(() {

       });
    }
  }

  void _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneNumberTEController.text.trim(), // ✅ fixed
    };

    if(_passwordTEController.text.isNotEmpty){
      requestBody ['password'] = _passwordTEController.text;
    }

    if(_pickedImage != null){
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodedImage = await base64Encode(imageBytes);
      requestBody ['photo'] = encodedImage;
    }

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    setState(() {});

    if (response.isSuccess) {

      _passwordTEController.clear();
      ShowSnackBarMessage(context, "User data updated Successfully");
    } else {
      ShowSnackBarMessage(context, response.errorMessage, true);
    }
  }




}
