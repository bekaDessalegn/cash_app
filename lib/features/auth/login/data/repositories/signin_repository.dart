import 'dart:io';

import 'package:cash_app/features/auth/login/data/datasources/signin_datasource.dart';
import 'package:cash_app/features/auth/login/data/models/signin.dart';

class SignInRepository{
  SignInDataSource signInDataSource;
  SignInRepository(this.signInDataSource);

  Future signInAffiliate(SignIn signIn) async {
    try{
      await signInDataSource.signInAffiliate(signIn);
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

  Future forgotPassword(String email) async {
    try {
      await signInDataSource.forgotPassword(email);
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

  Future recoverPassword(String recoveryToken, String newPasswordHash) async {
    try {
      print("REcovery on the way");
      await signInDataSource.recoverPassword(recoveryToken, newPasswordHash);
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

  Future adminResetPassword(String recoveryToken, String newHashPassword) async {
    try {
      await signInDataSource.adminResetPassword(recoveryToken, newHashPassword);
    } on HttpException {
      print("http");
      throw const HttpException("404");
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } on Exception {
      print("EXp");
      throw Exception();
    }
  }
}