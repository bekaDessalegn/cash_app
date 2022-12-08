import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const String apiKey = "2S9f4e2D886aGa231caH2H44f2R25Jf487cDfaa3G";
// const String baseUrl = "http://localhost:5000";
// const String baseUrl = "https://cash-mart.onrender.com";
// const String baseUrl = "https://api-cashmart.onrender.com";
const String baseUrl = "http://192.168.43.166:5000";
const String hostUrl = "https://cashmart.netlify.app";

enum SocialMedia {facebook, whatsapp, telegram, twitter, linkedin}
bool isWelcome = false;
double joiningBonus = 0;

final formKey = GlobalKey<FormState>();
final signupFormKey = GlobalKey<FormState>();
final verifyFormKey = GlobalKey<FormState>();
final phoneOrEmail = TextEditingController();
final password = TextEditingController();
final signupFullNameController = TextEditingController();
final signupPasswordController = TextEditingController();
final signupPhoneController = PhoneController(null);
final signupEmailController = TextEditingController();
final verifySignUpController = TextEditingController();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> detailScaffoldKey = GlobalKey<ScaffoldState>();

Future getAccessTokens() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("accessToken");
}

Future getRefreshTokens() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("refreshToken");
}

Future getUserId() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("user_id");
}

Future share({required SocialMedia socialPlatform, required String shareLink}) async {
  final urlShare = Uri.encodeComponent(shareLink);

  final urls = {
    SocialMedia.facebook : 'https://www.facebook.com/sharer/sharer.php?u=$urlShare',
    SocialMedia.telegram : 'https://t.me/share/url?url=$urlShare',
    SocialMedia.whatsapp : 'https://api.whatsapp.com/send/?text=$urlShare',
    SocialMedia.twitter : "https://twitter.com/intent/tweet?text=$urlShare",
    SocialMedia.linkedin : "https://www.linkedin.com/sharing/share-offsite/?url=$urlShare",
  };
  final url = Uri.parse(urls[socialPlatform]!);

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}
