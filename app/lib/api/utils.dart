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

  if (!_ok(response)) {
    throw RequestFailed(response.statusCode);
  }

  return json.decode(response.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> postWithAuth(
    dynamic url, Map<String, dynamic> body) async {
  final uri = await addToken(toUri(url));

  final jsonBody = json.encode(body);

  final response = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonBody,
  );

  if (!_ok(response)) {
    throw RequestFailed(response.statusCode);
  }

  return json.decode(response.body) as Map<String, dynamic>;
}

bool _ok(http.Response resp) {
  return 200 <= resp.statusCode && resp.statusCode < 300;
}

class RequestFailed extends Error {
  final int statusCode;

  RequestFailed(this.statusCode);

  @override
  String toString() {
    return "Request failed <${statusCode}>";
  }
}
