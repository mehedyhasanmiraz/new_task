import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:new_task/app.dart';
import 'package:new_task/ui/controllers/auth_controller.dart';
import 'package:new_task/ui/screens/login_screen.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage = "Something went wrong! Try again,",
  });
}

class NetworkClient {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      // Add additional headers for better compatibility
      Map<String, String> headers = {"token": AuthController.token ?? ''};

      _preRequestLog(url, headers);

      Response response = await get(uri, headers: headers).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );
      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      }    else if(response.statusCode == 401){
        _moveToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
            errorMessage: "Un-Authorised user, please login again!"
        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson["data"] ?? "Something went wrong!";
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      _logger.e("Network Error: ${e.toString()}");
      _postRequestLog(url, -1, errorMessage: e.toString());

      // Provide more specific error messages for common issues
      String errorMessage = e.toString();
      if (e.toString().contains('Failed to fetch')) {
        errorMessage =
        "Network connection failed. Please check your internet connection or try again later.";
      } else if (e.toString().contains('timeout')) {
        errorMessage = "Request timed out. Please try again.";
      }

      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: errorMessage,
      );
    }
  }


  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      // Add additional headers for better compatibility
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "token": AuthController.token ?? '',
      };

      _preRequestLog(url, headers, body: body);
      Response response =
          await post(uri, headers: headers, body: jsonEncode(body)).timeout(
            Duration(seconds: 30),
            onTimeout: () {
              throw Exception('Request timeout');
            },
          );
      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      }  else if(response.statusCode == 401){
        _moveToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
            errorMessage: "Un-Authorised user, please login again!"
        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        String errorMessage = decodedJson["data"] ?? "Something went wrong!";
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      _logger.e("Network Error: ${e.toString()}");
      _postRequestLog(url, -1, errorMessage: e.toString());

      // Provide more specific error messages for common issues
      String errorMessage = e.toString();
      if (e.toString().contains('Failed to fetch')) {
        errorMessage =
            "Network connection failed. Please check your internet connection or try again later.";
      } else if (e.toString().contains('timeout')) {
        errorMessage = "Request timed out. Please try again.";
      }

      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: errorMessage,
      );
    }
  }

  static void _preRequestLog(
    String url,
    Map<String, String> headers, {
    Map<String, dynamic>? body,
  }) {
    _logger.i(
      "URL=> $url\nHeaders: $headers\n"
      "Body=> $body",
    );
  }

  static void _postRequestLog(
    String url,
    int statusCode, {
    Map<String, dynamic>? headers,
    dynamic responseBody,
    dynamic errorMessage,
  }) {
    if (errorMessage != null) {
      _logger.e(
        "Url: $url\n"
        "StatusCode: $statusCode\n"
        "Error message: $errorMessage",
      );
    } else {
      _logger.i(
        "Url: $url\n"
        "StatusCode: $statusCode\n"
        "Headers: $headers\n"
        "Response Body: $responseBody",
      );
    }
  }

  static void _moveToLoginScreen() async {
    await AuthController.clearUserInformation();
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (cotext) => LoginScreen()),
      (predicate) => false,
    );
  }
}
