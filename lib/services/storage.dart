import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

Future<void> saveList(String listName, List<String> list) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(listName, list);
}

Future<List<String>> getList(String listName) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(listName) ?? List<String>();
}

Future<void> addToList(String listName, String element) {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(listName, getList(listName).add(element));
}