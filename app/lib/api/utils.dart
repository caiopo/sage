import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<String> token() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user.getIdToken();
}

Uri toUri(dynamic url) {
  if (url is String) {
    return Uri.parse(url);
  }

  if (url is Uri) {
    return url;
  }

  throw ArgumentError(
    'url must be String or Uri, found ${url.runtimeType.toString()}',
  );
}

Future<Uri> addToken(Uri uri) async {
  final query = Map.of(uri.queryParameters);

  query['token'] = await token();

  return uri.replace(queryParameters: query);
}

Future<Map<String, dynamic>> getWithAuth(dynamic url) async {
  final uri = await addToken(toUri(url));

  final response = await http.get(uri);

  return json.decode(response.body) as Map<String, dynamic>;
}
