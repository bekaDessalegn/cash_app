import 'dart:convert';
import 'dart:io';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/auth/signup/data/models/signup.dart';
import 'package:http/http.dart' as http;

class SignUpDataSource{
  AuthService authService = AuthService();
  final _prefs = PrefService();

  var verificationToken;

  Future signupAffiliate(SignUp signUp) async{
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/sign-up');

    var body = {
      "fullName": signUp.fullName,
      "phone": signUp.phone,
      "email": signUp.email,
      "passwordHash": signUp.passwordHash,
      "parentId": signUp.parentId
    };

    try{
      var res = await http.post(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        verificationToken = data["verificationToken"];
      } else if(data["message"] == "Affiliate_Email_Already_Exist") {
        print(data);
        throw const HttpException("Affiliate_Email_Already_Exist");
      } else if(data["message"] == "Affiliate_Phone_Already_Exist") {
        print(data);
        throw const HttpException("Affiliate_Phone_Already_Exist");
      } else if(data["message"] == "Invalid_Email"){
        return "Invalid_Email";
      } else{
        print(data);
        throw Exception();
      }
    } on SocketException{
      throw Exception();
    }
  }

  Future verifySignUp(String verificationCode) async{
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/verify-sign-up');

    var body = {
      "verificationToken": verificationToken,
      "verificationCode": verificationCode
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    try{
      var res = await http.post(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        joiningBonus = data["affiliate"]["wallet"]["totalMade"];
        await authService.setAccessToken(accessToken: data["accessToken"]);
        await authService.setRefreshToken(refreshToken: data["refreshToken"]);
        await authService.setUserId(userId: data["affiliate"]["userId"]);
        await _prefs.createUserId(data["affiliate"]["userId"]);
        // await _prefs.createJoiningBonus(data["affiliate"]["wallet"]["totalMade"]);
      } else if(data["message"] == "Wrong_Verification_Code") {
        print(data);
        throw const HttpException("Wrong_Verification_Code");
      } else if(data["message"] == "Expired_Token") {
        print(data);
        throw const HttpException("Expired_Token");
      } else{
        print(data);
        throw Exception();
      }
    } on SocketException{
      throw Exception();
    }
  }

}