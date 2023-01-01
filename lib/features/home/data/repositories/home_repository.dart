import 'dart:io';

import 'package:cash_app/features/home/data/datasources/home_datasource.dart';
import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:cash_app/features/home/data/models/logo_image.dart';
import 'package:cash_app/features/home/data/models/social_links.dart';
import 'package:cash_app/features/home/data/models/video_links.dart';
import 'package:cash_app/features/products/data/models/products.dart';

class HomeRepository {
  HomeDataSource homeDataSource;
  HomeRepository(this.homeDataSource);

  Future<List<Products>> newInStoreProducts() async{
    try{
      print("New In Store Products Success");
      final products = await homeDataSource.newInStoreProducts();
      return products;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } catch(e) {
      print(e);
      throw Exception();
    }
  }

  Future filterFetauredProducts() async{
    try{
      print("Filter Published Products Success");
      final products = await homeDataSource.filterFeaturedProducts();
      return products;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } catch(e) {
      print(e);
      throw Exception();
    }
  }

  Future filterTopSellerProducts() async{
    try{
      print("Filter Top Seller Products Success");
      final products = await homeDataSource.filterTopSellerProducts();
      return products;
    } on SocketException {
      print("Socket");
      throw SocketException("No Internet");
    } catch(e) {
      print(e);
      throw Exception();
    }
  }

  Future<VideoLinks> getVideoLinks() async{
    try{
      final videoLinks = await homeDataSource.getVideoLinks();
      return videoLinks;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

  Future<HomeContent> getHomeContent() async{
    try{
      final homeContent = await homeDataSource.getHomeContent();
      return homeContent;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

  Future<LogoImage> getLogoImage() async{
    try{
      final logoImage = await homeDataSource.getLogoImage();
      return logoImage;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

  Future<List<SocialLinks>> getFooter() async {
    try{
      final footerContent = await homeDataSource.getFooterContent();
      return footerContent;
    } catch(e){
      print(e);
      throw Exception();
    }
  }

}