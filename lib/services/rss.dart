import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

import 'dart:async';

Future<RssFeed> getRssFeed(String url) async {
  xml = await http.read(url);
  return RssFeed.parse(xml);
}