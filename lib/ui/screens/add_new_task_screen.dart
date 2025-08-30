import 'package:flutter/material.dart';
import 'package:new_task/data/service/network_client.dart';
import 'package:new_task/ui/utills/snack_bar_message.dart';
import 'package:new_task/ui/utills/urls.dart';
import 'package:new_task/ui/widgets/screen_background.dart';
import 'package:new_task/ui/widgets/tm_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}


class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    controller: _titleTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Title"),
                    validator: (String? value){
                      if(value?.trim().isEmpty  ?? true){
                        return "Enter your Title";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 6,
                    textInputAction: TextInputAction.next,
                     controller: _descriptionTEController,
                    decoration: InputDecoration(
                        hintText: "Description",
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Enter task description";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Visibility(
                      visible: _addNewTaskInProgress == false,
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

  void _onTapSubmitButton() {
    if(_formKey.currentState!.validate()){
      _addNewTask();
    }

  }

  Future<void> _addNewTask()async{
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String , dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };

    final NetworkResponse response = await NetworkClient.postRequest(url: Urls.crateTaskUrl, body: requestBody);

    _addNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      _clearTextFields();
      showSnackBarMessage(context, "New Task Added");
    }else{
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  void _clearTextFields(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
