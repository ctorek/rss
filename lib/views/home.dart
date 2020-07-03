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
                // Add all items to single list
                var allItems = List<RssItem>();
                snapshot.data.forEach((feed) {
                  allItems.addAll(feed.items);
                });

                // Sort list by item publish date
                /* lmao this shit broke
                allItems.sort((a, b) {
                  return (DateTime.parse(a.pubDate)).compareTo(DateTime.parse(b.pubDate));
                }); */

                print(allItems.length);

                return Expanded(
                  child: ListView.builder(
                    itemCount: allItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ListTile(
                        title: Text(allItems[index].title),
                        subtitle: Text(allItems[index].pubDate),
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
            future: getRssFeedsStorage()
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
