import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path,"cash_admin.db");

    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE LocalAboutUsContent(
          heroShortTitle TEXT,
          heroLongTitle TEXT,
          heroDescription TEXT,
          whoAreWeDescription TEXT,
          whoAreWeVideoLink TEXT,
          howToBuyFromUsDescription TEXT,
          howToAffiliateWithUsDescription TEXT,
          howToAffiliateWithUsVideoLink TEXT
          )"""
          );
          await db.execute("""
          CREATE TABLE Product(
          productId TEXT PRIMARY KEY,
          productName TEXT,
          price REAL,
          commission REAL,
          published BOOLEAN,
          featured BOOLEAN,
          topSeller BOOLEAN,
          viewCount INTEGER
          )"""
          );
          await db.execute("""
          CREATE TABLE LogoImage(
          id TEXT PRIMARY KEY,
          logoImage BLOB
          )"""
          );
          await db.execute("""
          CREATE TABLE Affiliate(
          userId TEXT PRIMARY KEY,
          fullName TEXT,
          phone TEXT,
          email TEXT,
          totalRequests REAL,
          acceptedRequests REAL,
          rejectedRequests REAL,
          totalMade REAL,
          currentBalance REAL,
          canWithdrawAfter REAL,
          memberSince TEXT
          )"""
          );
          await db.execute("""
          CREATE TABLE Transactions(
          transactionId TEXT PRIMARY KEY,
          kind TEXT,
          amount REAL,
          transactedAt TEXT
          )"""
          );
        },
    );
  }
}