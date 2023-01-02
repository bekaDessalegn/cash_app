import 'package:cash_app/core/services/database_helper.dart';
import 'package:cash_app/features/affiliate_wallet/data/models/local_transactions.dart';
import 'package:sqflite/sqflite.dart';

class TransactionsLocalDb {

  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<int> addTransactions(LocalTransactions transactions) async{ //returns number of items inserted as an integer
    final db = await databaseHelper.init(); //open database

    return db.insert("Transactions", transactions.toJson(), //toMap() function from MemoModel
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<int> updateTransaction(String id, Map<String, dynamic> update) async{ // returns the number of rows updated

    final db = await databaseHelper.init();

    int result = await db.update(
        "Transactions",
        update,
        where: "transactionId = ?",
        whereArgs: [id]
    );
    return result;
  }

  Future<int> deleteTransaction(String id) async{ // returns the number of rows updated

    final db = await databaseHelper.init();

    int result = await db.delete(
        "Transactions",
        where: "transactionId = ?",
        whereArgs: [id]
    );
    return result;
  }

  Future deleteAllTransactions() async {
    final db = await databaseHelper.init();
    // return db.delete("delete from "+ TABLE_NAME);
    int deleted = await db.rawDelete("Delete from Transactions");
    print(deleted);
    return deleted;
  }

  Future<LocalTransactions> getTransactions() async{ //returns the memos as a list (array)

    final db = await databaseHelper.init();
    final maps = await db.query("Transactions"); //query all the rows in a table as an array of maps

    print("Recieved Transactions data in the Local Database");
    print(maps[0]);

    return LocalTransactions.fromJson(maps[0]);
  }

  Future<List<LocalTransactions>> getListTransactions() async {
    final db = await databaseHelper.init();
    final maps = await db.query("Transactions"); //query all the rows in a table as an array of maps

    List<LocalTransactions> transactions = [];
    for(var transaction in maps){
      transactions.add(LocalTransactions.fromJson(transaction));
    }

    return transactions;
  }
}