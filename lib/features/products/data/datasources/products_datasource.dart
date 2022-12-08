import 'dart:convert';
import 'dart:io';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/products/data/models/categories.dart';
import 'package:cash_app/features/products/data/models/orders.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:http/http.dart' as http;

Products? product_contents;

class ProductsDataSource {

  int limit = 9;

  Future<List<Products>> getProducts() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products?filter={"published" : true}&select=["productName","price","viewCount","mainImage", "commission", "categories", "featured", "published", "topSeller"]');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);
      List content = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final List<Products> products =
            content.map((product) => Products.fromJson(product)).toList();
        print(data);
        return products;
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future<List<Products>> getProductsForList(int skipNumber) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products?filter={"published" : true}&select=["productName","price","viewCount","mainImage", "commission", "categories", "featured", "published", "topSeller"]&limit=$limit&skip=$skipNumber');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);
      List content = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final List<Products> products =
        content.map((product) => Products.fromJson(product)).toList();
        print(data);
        return products;
      } else if(res.statusCode == 429){
        print("Too many requests");
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future<Products> getProduct(String? productId) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products/$productId');

    try{
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final product = Products.fromJson(data);
        product_contents = product;
        print(data);
        return product;
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future<List<Products>> searchProducts(String productName) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products?filter={"published" : true}&search={"productName" : "$productName"}&select=["productName","price","viewCount","mainImage", "commission", "categories", "featured", "published", "topSeller"]&limit=$limit');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);
      List content = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final List<Products> products =
        content.map((product) => Products.fromJson(product)).toList();
        return products;
      } else if(res.statusCode == 429){
        print("Too many requests");
        throw Exception();
      }
      else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future<List<Products>> filterProductsByCategory(String categoryName, int skipNumber) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/products?filter={"published" : true}&categories=["$categoryName"]&select=["productName","price","viewCount","mainImage", "commission", "categories", "featured", "published", "topSeller"]&limit=$limit&skip=$skipNumber');

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
      print("Socket Socket");
      throw Exception();
    }
  }

  Future<List<Categories>> getCategories() async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
    };
    var url = Uri.parse('$baseUrl/product-categories');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      final List content = json.decode(resBody);
      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);

        final List<Categories> categories =
            content.map((category) => Categories.fromJson(category)).toList();

        return categories;
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future postOrders(Orders orders) async {
    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/orders');

    var body = {
      "product": {
        "productId": orders.productId
      },
      "orderedBy": {
        "fullName": orders.fullName,
        "phone": orders.phone,
        if(orders.companyName!.isNotEmpty) "companyName": orders.companyName
      },
      "affiliate": {
        "userId": orders.userId
      }
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
