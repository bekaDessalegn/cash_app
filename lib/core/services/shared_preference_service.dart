import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("password", password);
  }

  Future readCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("password");
    return cache;
  }

  Future removeCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("password");
  }

  Future createCookie(String cookie) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("cookie", cookie);
  }

  Future readCookie() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cookie = _preferences.getString("cookie");
    return cookie;
  }

  Future removeCookie() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("cookie");
  }

  Future createAffiliateLink(String affLink) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("affLink", affLink);
  }

  Future readAffiliateLink() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var affLink = _preferences.getString("affLink");
    return affLink;
  }

  Future removeAffiliateLink() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("affLink");
  }

  Future createUserId(String userId) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("userId", userId);
  }

  Future readUserId() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString("userId");
    return userId;
  }

  Future removeUserId() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("userId");
  }

  Future createJoiningBonus(double bonus) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setDouble("bonus", bonus);
  }

  Future readJoiningBonus() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var bonus = _preferences.getDouble("bonus");
    return bonus;
  }

  Future removeJoiningBonus() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("bonus");
  }

  Future removeAffiliateId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove("user_id");
  }

  Future createOnBoarding() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool("onBoarding", true);
  }

  Future readOnBoarding() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var onBoarding = _preferences.getString("onBoarding");
    return onBoarding;
  }

  Future removeOnBoarding() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("onBoarding");
  }

}