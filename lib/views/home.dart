import 'package:flutter/material.dart';

import 'package:webfeed/webfeed.dart';

import './edit.dart';
import '../services/rss.dart';

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
            onPressed: () => setState(() {})
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FutureBuilder(
            builder: (BuildContext ctxt, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                //print(allItems.length);
                var all = List<RssItem>();
                snapshot.data.forEach((feed) {
                  all.addAll(feed.items);
                });

                return Expanded(
                  child: ListView.builder(
                    itemCount: all.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                            title: Text(all[index].title),
                            subtitle: Text(all[index].pubDate),
                            contentPadding: EdgeInsets.all(16.0)
                        );
                    },
                  )
                );
              }
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            },
            future: getFeedsAsList()
          )
        ]
      ),
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
