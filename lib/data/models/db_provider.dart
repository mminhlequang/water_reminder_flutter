// import 'dart:convert';
// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';



// class DBProvider {
//   DBProvider._();
//   static final DBProvider db = DBProvider._();
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       print("have database");
//       return _database!;
//     }

//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database!;
//   }

//   initDB() async {
//     print("not have database");
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     // Get a location using getDatabasesPath
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'irace.db');
//     return await openDatabase(path, version: 3, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE TrackingData ("
//           "id INTEGER PRIMARY KEY,"
//           "target STRING PRIMARY KEY"
//           "date STRING,"
//           "record DOUBLE,"
//           "capacity STRING,"
//           "time STRING"
//           "json TEXT,"
//           ")");
//     });
//   }

//   createRecord(DataModelDrinkWater data) async {
//     var res;
//     try {
//       final db = await database;
//       res = await db.insert("Drink Water", data.toMap(data));
//     } catch (e) {
//       print("adataaa $e");
//     }
//     return res;
//   }

//   Future<List<DataModelDrinkWater>> getAllData() async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT json FROM TrackingData");
//     List<DataModelDrinkWater>? list = [];
//     var listCast = res.cast<Map<String, dynamic>>();
//     list = await listCast.map<DataModelDrinkWater>((json) {
//       return DataModelDrinkWater.fromJson(jsonDecode(json['json']));
//     }).toList();
//     print("lenght 1: " + list.length.toString());
//     return list;
//   }
// }
