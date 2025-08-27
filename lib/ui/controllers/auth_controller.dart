import 'dart:convert';
import 'package:new_task/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static const String _tokenKey = 'token';
  static const String _userData = 'user-data';

  /// save user information
  static Future<void> saveUserInformation(String accessToken, UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(_userData, jsonEncode(user.toJson()));

    token = accessToken;
    userModel = user;   // ✅ ঠিকভাবে static variable এ সেভ হচ্ছে
  }

  /// get user information
  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? savedUserString = sharedPreferences.getString(_userData);

    if (savedUserString != null) {
      UserModel savedUser = UserModel.fromJson(jsonDecode(savedUserString));
      userModel = savedUser;
    }
    token = accessToken;
  }

  /// check user logged in
  static Future<bool> checkIfUserLoggedIn()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(_tokenKey);
    if(userAccessToken !=null){
     await getUserInformation();
      return true;
    }
    return false;
  }

  /// clear user info (logout)
  static Future<void> clearUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.clear();
    // await sharedPreferences.remove(_tokenKey);
    // await sharedPreferences.remove(_userData);
    //
    token = null;
    userModel = null;
  }
}
