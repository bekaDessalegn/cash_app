import 'dart:convert';
import 'dart:io';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/about_us/data/datasources/local/logo_local_datasource.dart';
import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:cash_app/features/home/data/models/logo_image.dart';
import 'package:cash_app/features/home/data/models/social_links.dart';
import 'package:cash_app/features/home/data/models/video_links.dart';
import 'package:cash_app/features/products/data/datasources/local/products_local_datasource.dart';
import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:http/http.dart' as http;

class HomeDataSource {

  ProductLocalDb productLocalDb = ProductLocalDb();
  LogoImageLocalDb logoImageLocalDb = LogoImageLocalDb();

  Future newInStoreProducts() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products?filter={"published" : true}&limit=4&select=["productName","price","mainImage", "commission"]');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      print("This is it");
      print(resBody);
      print(res.statusCode);

      var data = json.decode(resBody);

      List content = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print("aaaaaaaaaaaaaaaaaaaaa");
        final List<Products> products = content.map((product) => Products.fromJson(product)).toList();
        // print(data);
        return products;
      }else if(res.statusCode == 429){
        print("Too many requests");
        throw Exception();
      }
      else {
        print(data);
        print("Something Something hard");
        throw Exception();
      }
    } on SocketException {
      final localProduct = await productLocalDb.getListProducts();
      var newProducts = localProduct.take(4);
      return newProducts;
    }
  }

  Future filterFeaturedProducts() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products?filter={"featured" : true, "published" : true}&select=["productName","price","mainImage", "commission"]');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      print("This is it");
      print(resBody);
      print(res.statusCode);

      var data = json.decode(resBody);

      List content = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print("FILTER FILTER FILTER FILTER");
        final List<Products> products = content.map((product) => Products.fromJson(product)).toList();
        // print(data);
        return products;
      } else if(res.statusCode == 429){
        print("Too many requests");
        throw Exception();
      }
      else {
        print(data);
        print("Something Something hard");
        throw Exception();
      }
    } on SocketException {
      final localProduct = await productLocalDb.getListProducts();
      var featuredProducts = localProduct.map((json) => LocalProducts.fromJson(json.toJson())).where((element) {
        return element.featured == true;
      }).toList();
      return featuredProducts;
    }
  }

  Future filterTopSellerProducts() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products?filter={"topSeller" : true, "published" : true}&select=["productName","price","mainImage", "commission"]');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      print("This is it");
      print(resBody);
      print(res.statusCode);

      var data = json.decode(resBody);

      List content = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print("FILTER TOP SELLER");
        final List<Products> products = content.map((product) => Products.fromJson(product)).toList();
        // print(data);
        return products;
      } else if(res.statusCode == 429){
        print("Too many requests");
        throw Exception();
      }
      else {
        print(data);
        print("Something Something hard");
        throw Exception();
      }
    } on SocketException {
      final localProduct = await productLocalDb.getListProducts();
      var topSellerProducts = localProduct.map((json) => LocalProducts.fromJson(json.toJson())).where((element) {
        return element.topSeller == true;
      }).toList();
      return topSellerProducts;
    }
  }

  Future<VideoLinks> getVideoLinks() async {

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey
    };
    var url = Uri.parse('$baseUrl/static-web-contents');

    try{
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        if(data["videoLinks"].toString() != "null"){
          final videoLinks = VideoLinks.fromJson(data["videoLinks"]);
          return videoLinks;
        } else{
          return VideoLinks(whoAreWe: "null", howToAffiliateWithUs: "null");
        }
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

  Future<HomeContent> getHomeContent() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey
    };
    var url = Uri.parse('$baseUrl/static-web-contents?select=["heroImage", "heroShortTitle", "heroLongTitle", "heroDescription", "whyUsImage", "whyUsTitle", "whyUsDescription", "whatMakesUsUnique" , "whatMakesUsUniqueImage", "brands", "socialLinks" ]');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      final data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final homeContent = HomeContent.fromJson(data);
        print(data);
        return homeContent;
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

  Future<LogoImage> getLogoImage() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey
    };
    var url = Uri.parse('$baseUrl/static-web-contents?select=["logoImage"]');

    try{
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var data = json.decode(resBody);
        var _imageBase64;

        http.Response imageResponse = await http.get(Uri.parse("$baseUrl${data["logoImage"]["path"]}"));
        _imageBase64 = base64Encode(imageResponse.bodyBytes);

        await logoImageLocalDb.addLogoImage(LogoImage(logoImage: base64Decode(_imageBase64)));

        await logoImageLocalDb.updateLogoImage(LogoImage(logoImage: base64Decode(_imageBase64)).toJson());

        final localLogoImage = await logoImageLocalDb.getLogoImage();

        // final logoImage = LogoImage.fromJson(data);
        return localLogoImage;
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      final localLogoImage = await logoImageLocalDb.getLogoImage();
      return localLogoImage;
    }
  }

  Future<List<SocialLinks>> getFooterContent() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey
    };
    var url = Uri.parse('$baseUrl/static-web-contents?select=["socialLinks"]');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      final data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        List contents = data["socialLinks"];
        List<SocialLinks> footerContent = contents.map((content) => SocialLinks.fromJson(content)).toList();
        return footerContent;
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