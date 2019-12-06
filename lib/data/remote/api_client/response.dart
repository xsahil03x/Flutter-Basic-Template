import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

@immutable
class Response {
  final http.BaseResponse base;
  final dynamic body;

  Response(this.base, this.body);

  Response replace({http.BaseResponse base, dynamic body}) =>
      Response(base ?? this.base, body ?? this.body);

  int get statusCode => base.statusCode;

  bool get isSuccessful => statusCode >= 200 && statusCode < 300;

  Map<String, String> get headers => base.headers;

  Uint8List get bodyBytes =>
      base is http.Response ? (base as http.Response).bodyBytes : null;

  String get bodyString =>
      base is http.Response ? (base as http.Response).body : null;
}
