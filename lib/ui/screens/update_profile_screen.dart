import 'package:flutter/material.dart';
import 'package:new_task/ui/widgets/screen_background.dart';
import 'package:new_task/ui/widgets/tm_appbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(fromProfileScreen: true),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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
                  // controller: _firstNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: "First Name"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  // controller: _lastNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: "Last Name"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  // controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  // controller: _phoneNumberTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: "Phone Number"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  // controller: _passwordTEController,
                  textInputAction: TextInputAction.next,

                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Text("Submit"),
                  ),
                ),
              ],
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
                        child: Text("Select your Photo"),
                      )
                    ],
                  ),
                ),
    );
  }

  void _onTapPhotoPicker(){

  }

  void _onTapSubmitButton() {}
}
