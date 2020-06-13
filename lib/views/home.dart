import 'package:flutter/material.dart';

import './edit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RSS Reader"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh feed",
            onPressed: () {
              // Refreshes state
              setState(() {});
            }
          )
        ],
      ),
      body: Scaffold(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Redirect to edit page screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditPage())
          );
        }
      ),
    );
  }
}
