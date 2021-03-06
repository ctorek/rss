import 'package:validators/validators.dart';
import 'package:flutter/material.dart';

import "../services/storage.dart";

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _editFormKey = GlobalKey<FormState>();
  final _editController = TextEditingController();

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back button in AppBar automatically added
        title: Text("Add New RSS Source"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            key: _editFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _editController,
                    validator: (value) {
                      if (!isURL(value)) {
                        return "Value is not a valid URL.";
                      }
                      return null;
                    },
                  )
                )
              ]
            )
          ),
          FutureBuilder(
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                          leading: Icon(Icons.rss_feed),
                          title: Text(snapshot.data[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                deleteFromList("feeds", index);
                              });
                              Scaffold.of(ctx).showSnackBar(SnackBar(
                                content: Text("URL successfully deleted")
                              ));
                            },
                          ),
                        );
                      },
                    )
                );
              },
              future: getList("feeds")
            )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // Save new list of RSS feeds, go back to home
          if (_editFormKey.currentState.validate()) {
            setState(() {
              addToList("feeds", _editController.text);
              _editController.clear();
            });
          }
        }
      ),
    );
  }
}
