import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back button in AppBar automatically added
        title: Text("Add New RSS Source"),
      ),
      body: Scaffold(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // Save new list of RSS feeds, go back to home
          // TODO: saving new feeds
          Navigator.pop(context);
        }
      ),
    );
  }
}
