import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future launchURL(String url) async {
  var uri = Uri.parse(url).toString();
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

List<String> createKeys(String s) {
  List<String> list = <String>[];

  var curName = '';

  for(final i in s.split('')) {
    curName += i.toLowerCase();
    list.add(curName);
  }

  return list;
}

Timestamp get getCurrentTimestamp => Timestamp.fromDate(DateTime.now());

bool get isIos => Platform.isIOS;
