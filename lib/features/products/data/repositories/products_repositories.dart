import 'dart:io';

import 'package:cash_app/features/products/data/datasources/products_datasource.dart';
import 'package:cash_app/features/products/data/models/categories.dart';
import 'package:cash_app/features/products/data/models/orders.dart';
import 'package:cash_app/features/products/data/models/products.dart';

class ProductsRepository{
  ProductsDataSource productsDataSource;
  ProductsRepository(this.productsDataSource);

  Future<List<Products>> getProducts() async{
    try{
      print("Get Products Success");
      final products = await productsDataSource.getProducts();
      return products;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } on Exception {
      print("EXp");
      throw Exception();
    }
  }

  Future<List<Products>> getProductsForList(int skipNumber) async{
    try{
      print("Get Products for list Success");
      final products = await productsDataSource.getProductsForList(skipNumber);
      return products;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } on Exception {
      print("EXp");
      throw Exception();
    }
  }

  Future<List<Products>> searchProducts(String productName) async{
    try{
      print("Search Products Success");
      final products = await productsDataSource.searchProducts(productName);
      return products;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } catch(e) {
      print(e);
      throw Exception();
    }
  }

  Future<List<Products>> filterProductsByCategory(String categoryName, int skipNumber) async{
    try{
      print("Filter Products Success");
      final products = await productsDataSource.filterProductsByCategory(categoryName, skipNumber);
      return products;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } catch(e) {
      print(e);
      throw Exception();
    }
  }

  Future<Products> getProduct(String? productId) async {
    try{
      print("Get Product Success");
      final product = await productsDataSource.getProduct(productId);
      return product;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } on Exception {
      print("EXp");
      throw Exception();
    }
  }

  Future<List<Categories>> getCategories() async{
    try{
      print("Get Categories Success");
      final categories = await productsDataSource.getCategories();
      return categories;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } on Exception {
      print("EXp");
      throw Exception();
    }
  }

  Future postOrders(Orders orders) async {
    try{
      print("On the way to post orders");
      await productsDataSource.postOrders(orders);
    } catch(e){
      print(e);
      throw Exception();
    }
  }

}