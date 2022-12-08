import 'dart:convert';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/affiliate_wallet/data/models/transactions.dart';
import 'package:http/http.dart' as http;

class TransactionDataSource {
  AuthService authService = AuthService();
  final _prefs = PrefService();

  var refreshToken;
  var accessToken;
  var userId;

  int limit = 9;

  Future getNewAccessToken() async {
    await getRefreshTokens().then((value) {
      refreshToken = value;
    });

    await getAccessTokens().then((value) {
      accessToken = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Refresh-Token': '$refreshToken',
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/sessions/refresh');

    var res = await http.get(url, headers: headersList);
    final resBody = res.body;

    var data = json.decode(resBody);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("Meneshet mneshet");
      print(data);
      await authService.setAccessToken(accessToken: data["newAccessToken"]);
    } else if(data["message"] == "Invalid_Refresh_Token"){
      print("IT has entered");
      _prefs.removeCache();
      _prefs.removeAffiliateId();
      authService.logOut();
    } else {
      print(data);
      throw Exception();
    }
  }

  Future<List<Transactions>> getAffiliateTransactions(int skipNumber) async {

    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/transactions?limit=$limit&skip=$skipNumber');

    try{
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        List contents = json.decode(resBody);
        List<Transactions> transactions = contents.map((transaction) => Transactions.fromJson(transaction)).toList();
        return transactions;
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await getAffiliateTransactions(skipNumber);
      } else if(data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      }
      else {
        print(data);
        throw Exception();
      }
    } catch(e){
      print(e);
      throw Exception();
    }
  }
}