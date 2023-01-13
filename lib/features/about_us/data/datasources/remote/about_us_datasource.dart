import 'dart:convert';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/about_us/data/models/about_content.dart';
import 'package:http/http.dart' as http;

class AboutUsDataSource{
  Future<AboutUsContent> getAboutUsContent() async{
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey
    };
    var url = Uri.parse('$baseUrl/static-web-contents?select=["heroImage", "heroShortTitle", "heroLongTitle", "heroDescription", "whoAreWeImage", "whoAreWeDescription", "whoAreWeVideoLink", "howToBuyFromUsDescription", "howToAffiliateWithUsDescription", "howToAffiliateWithUsVideoLink"]');

    try{
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        final aboutUsContent = AboutUsContent.fromJson(data);
        return aboutUsContent;
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