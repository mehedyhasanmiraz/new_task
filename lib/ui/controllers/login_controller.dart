import 'package:get/get.dart';

import '../../data/models/login_model.dart';
import '../../data/service/network_client.dart';
import '../utills/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
    bool _loginInProgress = false;

    bool get loginInProgress => _loginInProgress;

    String? _errorMessage;
    String? get errorMessage => _errorMessage;

    Future<bool> loginUser(String email, String password)async{
        bool isSuccess = false;
        _loginInProgress = true;
        update();

        Map<String, dynamic> requestBody = {
            "email": email,
            "password": password,

        };

        NetworkResponse response = await NetworkClient.postRequest(
            url: Urls.loginUrl,
            body: requestBody,
        );

        if (response.isSuccess) {
            // clearTextField();

            LoginModel loginModel = LoginModel.fromJson(response.data!);
            /// TODO: save token to local
            await AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
            isSuccess = true;
            _errorMessage = null;
        } else {
            _errorMessage = response.errorMessage;
        }
        _loginInProgress = true;
        update();

        return isSuccess;
    }
}