import 'dart:io';

import 'package:cash_app/features/auth/signup/data/datasources/signup_datasource.dart';
import 'package:cash_app/features/auth/signup/data/models/signup.dart';

class SignUpRepository{
  SignUpDataSource signUpDataSource;
  SignUpRepository(this.signUpDataSource);

  Future singupAffiliate(SignUp signUp) async{
    try{
      final response = await signUpDataSource.signupAffiliate(signUp);
      return response;
    } on HttpException {
      print("http");
      print(HttpException);
      throw const HttpException("404");
    } on SocketException {
      print("stf");
      throw SocketException("No Internet");
    } on Exception {
      throw Exception();
    }
  }

  Future verifySignUp(String verificationCode) async {
    try{
      await signUpDataSource.verifySignUp(verificationCode);
    } on HttpException {
      print("http");
      throw const HttpException("404");
    } on SocketException {
      print("stf");
      throw SocketException("No Internet");
    } on Exception {
      throw Exception();
    }
  }
}