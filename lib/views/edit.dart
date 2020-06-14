import 'package:flutter/material.dart';

import "../services/storage.dart";

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
      body: Scaffold(
        body: FutureBuilder(
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return ListTile(
                    leading: Icon(Icons.rss_feed),
                    title: snapshot.data[index],
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          deleteFromList("", index);
                        });
                      },
                    ),
                  );
                },
              );
            }
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator()
            );
          },
          future: getList("")
        ),
      ),
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
