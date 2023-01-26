import 'dart:convert';
import 'dart:io';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/about_us/data/datasources/local/about_us_local_datasource.dart';
import 'package:cash_app/features/about_us/data/models/about_content.dart';
import 'package:cash_app/features/about_us/data/models/local_about_us.dart';
import 'package:http/http.dart' as http;

class AboutUsDataSource{

  AboutUsLocalDb aboutUsLocalDb = AboutUsLocalDb();

  Future getAboutUsContent() async{
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
        await aboutUsLocalDb.addLocalAboutUsContent(LocalAboutUsContent.fromJson(data));
        final updated = await aboutUsLocalDb.updateLocalAboutUsContent(LocalAboutUsContent.fromJson(data).toJson());
        return aboutUsContent;
      }
      else {
        print(data);
        throw Exception();
      }
    }  on SocketException {
      final aboutUs = await aboutUsLocalDb.getLocalAboutUsContent();
      return aboutUs;
    }
  }
}