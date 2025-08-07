import 'package:flutter/material.dart';
import 'package:new_task/ui/screens/new_task_screen.dart';
import 'package:new_task/ui/widgets/screen_background.dart';
import 'package:new_task/ui/widgets/tm_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  "Add New Task",
                  style: TextTheme.of(context).titleLarge,
                ),

                SizedBox(height: 20),
                TextFormField(
                  // controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLines: 6,
                  textInputAction: TextInputAction.next,
                  // controller: _passwordTEController,
                  decoration: InputDecoration(
                      hintText: "Description",
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                  ),
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

  void _onTapSubmitButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NewTaskScreen()),
      (pre) => false,
    );
  }
}
