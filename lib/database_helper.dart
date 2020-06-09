import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/coinList/model/modelCoinsList.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "crypkey.db");
    var ourDb = await openDatabase(path, version: 2, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    var dbClient = await db;

    await dbClient.execute(
        "CREATE TABLE Coins(row_id INTEGER PRIMARY KEY,id TEXT, symbol TEXT, name TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> addCoins(ModelCoinsList modelCoinsList) async {
    var dbClient = await db;

    int res = await dbClient.insert("Coins", modelCoinsList.toJson());
    return res;
  }

  Future<int> syncCoinData(List modelCoinsList) async {
    // syncCoinData
    try {
      var dbClient = await db;
      await dbClient.execute("DROP TABLE IF EXISTS coins");
      await dbClient.execute(
          "CREATE TABLE coins (id TEXT PRIMARY KEY, name TEXT NOT NULL, symbol TEXT NOT NULL)");

      await dbClient.transaction((txn) async {
        var batch = txn.batch();
        modelCoinsList.forEach((val) {
          batch.insert("coins", val.toJson());
        });
        await batch.commit(noResult: true);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<int> syncCurrencyData(List currencies) async {
    // syncCoinData
    try {
      var dbClient = await db;
      await dbClient.execute("DROP TABLE IF EXISTS currencies");
      await dbClient.execute(
          "CREATE TABLE currencies (currencyName TEXT NOT NULL,currencyValue TEXT NOT NULL)");


      await dbClient.transaction((txn) async {
        var batch = txn.batch();
        currencies.forEach((val) {
          batch.insert("currencies", val.toJson());
        });
        await batch.commit(noResult: true);


      });

    } catch (error) {
      print(error.toString());
    }
  }

  Future<int> syncCurrencyAndCoins(var coinListInsertionDateTime) async {
    // syncCoinData
    try {
      var dbClient = await db;
      await dbClient.execute("DROP TABLE IF EXISTS preferences");
      await dbClient.execute(
          "CREATE TABLE preferences (id TEXT PRIMARY KEY, coinPref TEXT NOT NULL, currencyPref TEXT NOT NULL)");

      Map<String, dynamic> row = {
        'coinPref': coinListInsertionDateTime,
        'currencyPref': 23
      };

      // do the insert and get the id of the inserted row
      int id = await dbClient.insert("preferences", row);

      print("id;" + id.toString());
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List> getCoinsData() async {
    // syncCoinData
    try {
      var dbClient = await db;

      var result = await dbClient.query("coins");

      return result.toList();
    } catch (error) {
      print(error.toString());
    }
  }
  Future<List> getCurrency() async {
    // syncCoinData
    try {
      var dbClient = await db;

      var result = await dbClient.query("currencies");

      return result.toList();
    } catch (error) {
      print(error.toString());
    }
  }
  //select * from sentences where title or body = userinput%
  Future<List> filterList(String userinput) async {
    // syncCoinData
    try {
      var dbClient = await db;

      var result = await dbClient.rawQuery(
          "SELECT * FROM coins WHERE name LIKE '%$userinput%' OR symbol LIKE '%$userinput%'");
      return result.toList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List> filterCurrencies(String userinput) async {
    // syncCoinData
    try {
      var dbClient = await db;

      var result = await dbClient.rawQuery(
          "SELECT * FROM currencies WHERE currencyValue LIKE '%$userinput%' OR currencyName LIKE '%$userinput%'");
      return result.toList();
    } catch (error) {
      print(error.toString());
    }
  }

  //deletionqq
//  Future<int> deleteUser(User user) async {
//    var dbClient = await db;
//    int res = await dbClient.delete("User");
//    return res;
//  }

//  Future<List> getAllCoins() async{
//    var dbClient = await db;
//    Batch batch = dbClient.batch();
//    citiesList.forEach((val) {
//      //assuming you have 'Cities' class defined
//      Cities city = Cities.fromMap(val);
//      batch.insert(tblCities, city.toMap());
//    });
//
//    batch.commit();
//
//  }

  Future<List<ModelCoinsList>> getAllUser() async {
    var dbClient = await db;
//    final List<Map<String, dynamic>> list = await dbClient.query('Coins');

    var res = await dbClient.query("Coins");

    List<ModelCoinsList> list = res.isNotEmpty
        ? res.map((c) => ModelCoinsList.fromJson(c)).toList()
        : null;
    return List.generate(list.length, (i) {
      print("list" + list.length.toString());
      return ModelCoinsList(
        id: list[i].id,
        name: list[i].name,
        symbol: list[i].symbol,
      );
    });
  }
}
