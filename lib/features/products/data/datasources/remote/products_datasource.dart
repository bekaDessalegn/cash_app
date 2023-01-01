import 'dart:convert';
import 'dart:io';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/products/data/datasources/local/products_local_datasource.dart';
import 'package:cash_app/features/products/data/models/categories.dart';
import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:cash_app/features/products/data/models/orders.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:http/http.dart' as http;

Products? product_contents;

class ProductsDataSource {

  int limit = 9;
  ProductLocalDb productLocalDb = ProductLocalDb();

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

  Future getProductsForList(int skipNumber) async {
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

        for (var product in data) {
          await productLocalDb.addProduct(LocalProducts(
              productId: product["productId"],
              productName: product["productName"],
              price: product["price"],
              published: product["published"],
              featured: product["featured"],
              topSeller: product["topSeller"],
              viewCount: product["viewCount"]));
          print("Has entered");
        }

        for (var product in data) {
          await productLocalDb.updateProduct(product["productId"], LocalProducts(
              productId: product["productId"],
              productName: product["productName"],
              price: product["price"],
              published: product["published"],
              featured: product["featured"],
              topSeller: product["topSeller"],
              viewCount: product["viewCount"]).toJson());
          print("Has entered");
        }

        final localProduct = await productLocalDb.getListProducts();
        List productIdList = [];
        for (var product in data){
          productIdList.add(product["productId"]);
        }

        for (var order in localProduct){
          if(productIdList.contains(order.productId)){
            continue;
          }
          var delete = await productLocalDb.deleteProduct(order.productId);
          print(delete);
        }

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
      final localProduct = await productLocalDb.getListProducts();
      return localProduct;
    }
  }

  Future getProduct(String? productId) async {
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
      return "Socket Error";
    }
  }

  Future searchProducts(String productName) async {
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
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      final localProduct = await productLocalDb.getListProducts();
      var searchedProducts = localProduct.map((json) => LocalProducts.fromJson(json.toJson())).where((element) {
        final productNameLowerCase = element.productName.toLowerCase();
        final valueLowerCase = productName.toLowerCase();
        return productNameLowerCase.contains(valueLowerCase);
      }).toList();
      return searchedProducts;
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
