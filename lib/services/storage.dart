import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Database> database;

Future<void> initDatabase() async {
  if (database != null) return;
  database = openDatabase(
    join(await getDatabasesPath(), "urls.db"),
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE urls(id INTEGER PRIMARY KEY, url TEXT, type TEXT)"
      );
    }
  );
}

Future<void> saveList(String listName, List<String> list) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(listName, list);
}

Future<List<String>> getList(String listName) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(listName) ?? List<String>();
}

Future<void> addToList(String listName, String element) async  {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(listName, (await getList(listName))..add(element));
}

Future<void> deleteFromList(String listName, int index) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(listName, (await getList(listName))..removeAt(index));
}
