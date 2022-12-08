import 'dart:convert';
import 'dart:io';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/auth/login/data/models/signin.dart';
import 'package:http/http.dart' as http;

class SignInDataSource {
  AuthService authService = AuthService();
  final _prefs = PrefService();

  Future signInAffiliate(SignIn signIn) async {

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/sign-in');

    var body = {
      "phoneOrEmail": signIn.phoneOrEmail,
      "passwordHash": signIn.passwordHash
    };

    try{
      var res = await http.post(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        await authService.setAccessToken(accessToken: data["accessToken"]);
        await authService.setRefreshToken(refreshToken: data["refreshToken"]);
        await authService.setUserId(userId: data["affiliate"]["userId"]);
        await _prefs.createUserId(data["affiliate"]["userId"]);
      } else if(data["message"] == "Wrong_Credentials" || data["message"] == "Invalid_Phone_Or_Email") {
        print(data);
        throw const HttpException("404");
      } else{
        print(data);
        throw Exception();
      }
    } on SocketException{
      throw Exception();
    }

  }

  Future forgotPassword(String email) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/forgot-password');

    var body = {
      "email": email
    };

    try{
      var res = await http.patch(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if(data["message"] == "User_Not_Found") {
        print(data);
        throw const HttpException("404");
      } else{
        print(data);
        throw Exception();
      }
    } on SocketException{
      throw Exception();
    }
  }

  Future recoverPassword(String recoveryToken, String newPasswordHash) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/recover-password');

    var body = {
      "recoveryToken": recoveryToken,
      "newPasswordHash": newPasswordHash
    };

    try{
      var res = await http.patch(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if(data["message"] == "Expired_Token") {
        print(data);
        throw const HttpException("404");
      } else{
        print(data);
        throw Exception();
      }
    } on SocketException{
      throw Exception();
    }
  }

  Future adminResetPassword(String recoveryToken, String newHashPassword) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/admin/recover-password');

    var body = {
      "recoveryToken": recoveryToken,
      "newPasswordHash": newHashPassword
    };

    try{
      var res = await http.put(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      }
      else if(data["message"] == "Expired_Token") {
        print(data);
        throw const HttpException("404");
      }
      else{
        throw Exception();
      }
    } on SocketException{
      throw Exception();
    }
  }

}