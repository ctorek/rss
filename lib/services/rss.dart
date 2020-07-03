import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import './storage.dart';

import 'dart:async';

Future<RssFeed> getRssFeed(String url) async {
  var xml = await http.read(url);
  return RssFeed.parse(xml);
}

Stream<RssFeed> getRssFeedsStorage() async* {
  final urls = await getList("feeds");
  var feeds = List<RssFeed>();
  for (var u in urls) {
    yield RssFeed.parse(await http.read(u));
  }
}

Future<List<RssFeed>> getFeedsAsList() async {
  var allFeeds = List<RssFeed>();
  await for (var feed in getRssFeedsStorage()) {
    allFeeds.add(feed);
  }
  return allFeeds;
}
