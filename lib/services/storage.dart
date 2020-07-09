import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Source {
  String url;
  String type;

  Source({this.url, this.type});

  Map<String, dynamic> toMap() {
    return {
      "url": url,
      "type": type
    };
  }
}

Future<Database> database;

Future<void> initDatabase() async {
  if (database != null) return;
  database = openDatabase(
    join(await getDatabasesPath(), "urls.db"),
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE urls(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, type TEXT)"
      );
    }
  );
}

Future<List<Source>> getAllSources() async {
  final db = await database;
  final List<Map<String, dynamic>> sourceMaps = await db.query("urls");
  
  return List.generate(sourceMaps.length, (i) {
    return Source(
      url: sourceMaps[i]["url"],
      type: sourceMaps[i]["type"]
    );
  });
}

Future<void> addSource(Source newSource) async  {
  final db = await database;
  await db.insert(
    "urls",
    newSource.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace
  );
}

Future<void> deleteSource(int id) async {
  final db = await database;
  await db.delete(
    "urls",
    where: "id = ?",
    whereArgs: [id]
  );
}
