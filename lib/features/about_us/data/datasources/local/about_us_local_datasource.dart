import 'package:cash_app/core/services/database_helper.dart';
import 'package:cash_app/features/about_us/data/models/local_about_us.dart';
import 'package:sqflite/sqflite.dart';

class AboutUsLocalDb {

  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<int> addLocalAboutUsContent(LocalAboutUsContent localAboutUsContent) async{ //returns number of items inserted as an integer
    final db = await databaseHelper.init(); //open database

    return db.insert("LocalAboutUsContent", localAboutUsContent.toJson(), //toMap() function from MemoModel
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<int> updateLocalAboutUsContent(Map<String, dynamic> update) async{ // returns the number of rows updated

    final db = await databaseHelper.init();

    int result = await db.update(
        "LocalAboutUsContent",
        update
    );
    return result;
  }

  Future deleteLocalAboutUsContent() async {
    final db = await databaseHelper.init();
    // return db.delete("delete from "+ TABLE_NAME);
    int deleted = await db.rawDelete("Delete from LocalAboutUsContent");
    print(deleted);
    return deleted;
  }

  Future<LocalAboutUsContent> getLocalAboutUsContent() async{ //returns the memos as a list (array)

    final db = await databaseHelper.init();
    final maps = await db.query("LocalAboutUsContent"); //query all the rows in a table as an array of maps

    print("Recieved LocalAboutUsContent data in the Local Database");
    print(maps[0]);

    return LocalAboutUsContent.fromJson(maps[0]);
  }
}