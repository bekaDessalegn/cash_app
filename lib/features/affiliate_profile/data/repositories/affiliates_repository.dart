import 'dart:io';

import 'package:cash_app/features/affiliate_profile/data/datasources/remote/affiliates_datasource.dart';
import 'package:cash_app/features/affiliate_profile/data/models/affiliates.dart';
import 'package:cash_app/features/affiliate_profile/data/models/avatar.dart';
import 'package:cash_app/features/affiliate_profile/data/models/children.dart';
import 'package:cash_app/features/affiliate_profile/data/models/parent_affiliate.dart';

class AffiliatesRepository {
  AffiliatesDataSource affiliatesDataSource;
  AffiliatesRepository(this.affiliatesDataSource);

  Future getAffiliate() async {
    try{
      print("Get Affiliate Success");
      final affiliate = await affiliatesDataSource.getAffiliate();
      return affiliate;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

  Future<ParentAffiliate> getParentAffiliate(String parentId) async {
    try{
      print("Getting Parent Affiliate");
      final affiliate = await affiliatesDataSource.getParentAffiliate(parentId);
      return affiliate;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

  Future<List<Children>> getChildren() async {
    try{
      print("Get Children Success");
      final children = await affiliatesDataSource.getChildren();
      return children;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

  Future<Avatar> putAvatar(Avatar avatar, List imageType) async{
    try{
      print("Put Avatar Success");
      return await affiliatesDataSource.putAvatar(avatar, imageType);
    } catch(e){
      print(e);
      throw Exception();
    }
  }

  Future patchFullName(String fullName) async {
    try{
      print("Patch Name Sucess");
      await affiliatesDataSource.patchFullName(fullName);
    }
    catch (e){
      print("Patch Name Not Sucessful");
      print(e);
      throw Exception(e);
    }
  }

  Future patchPhone(String phone) async {
    try{
      print("Patch Phone Success");
      final response = await affiliatesDataSource.patchPhone(phone);
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

  Future patchEmail(String email) async {
    try{
      print("Patch Email Success");
      await affiliatesDataSource.patchEmail(email);
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

  Future verifyEmail(String verificationCode) async {
    try{
      print("Verify Email Success");
      await affiliatesDataSource.verifyEmail(verificationCode);
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

  Future patchPassword(String oldPasswordHash, String newPasswordHash) async {
    try{
      print("Patch Password Success");
      await affiliatesDataSource.patchPassword(oldPasswordHash, newPasswordHash);
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

  Future deleteAvatar() async {
    try{
      print("Delete Avatar Success");
      await affiliatesDataSource.deleteAvatar();
    }
    catch (e){
      print("Delete Avatar Not Sucessful");
      print(e);
      throw Exception(e);
    }
  }

  Future deleteAffiliate(String passwordHash) async {
    try{
      print("On the way to delete Aff");
      await affiliatesDataSource.deleteAffiliate(passwordHash);
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

  Future signOut() async {
    try{
      print("Signout Sucess");
      await affiliatesDataSource.signout();
    }
    catch (e){
      print("Not Sucessful");
      print(e);
      throw Exception(e);
    }
  }

}