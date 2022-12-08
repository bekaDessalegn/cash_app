import 'dart:convert';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/contact_us/data/models/contact_us.dart';
import 'package:http/http.dart' as http;

class ContactUsDataSource {

  Future postContactUs(ContactUs contactUs) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/contact-us');

    print("WEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
    print(contactUs.fullName);
    print(contactUs.phone);
    print(contactUs.email);
    print(contactUs.address);
    print(contactUs.message);

    var body = {
      if(contactUs.fullName != "null") "fullName": contactUs.fullName,
      if(contactUs.phone != "null") "phone": contactUs.phone,
      if(contactUs.email != "null") "email": contactUs.email,
      if(contactUs.address != "null") "address": contactUs.address,
      "message": contactUs.message
    };

    try{
      var res = await http.post(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
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