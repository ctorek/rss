import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import './storage.dart';

import 'dart:async';

Future<RssFeed> getRssFeed(String url) async {
  var xml = await http.read(url);
  return RssFeed.parse(xml);
}

Future<List<RssFeed>> getRssFeedsStorage() async {
  final urls = await getList("feeds");
  var feeds = List<RssFeed>();
  urls.forEach((url) async {
    var xml = await http.read(url);
    feeds.add(RssFeed.parse(xml));
  });

  return feeds;
}
