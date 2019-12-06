import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import '../api_client/response.dart';
import 'package:lumberdash/lumberdash.dart';
import 'converter.dart';
import 'package:http/http.dart' as http;

const contentTypeKey = 'content-type';
const jsonHeaders = "application/json";
const formEncodedHeaders = "application/x-www-form-urlencoded";

@immutable
class JsonConverter implements Converter, ErrorConverter {
  const JsonConverter();

  Response _decodeJson(http.Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      // If we're decoding JSON, there's some ambiguity in https://tools.ietf.org/html/rfc2616
      // about what encoding should be used if the content-type doesn't contain a 'charset'
      // parameter. See https://github.com/dart-lang/http/issues/186. In a nutshell, without
      // an explicit charset, the Dart http library will fall back to using ISO-8859-1, however,
      // https://tools.ietf.org/html/rfc8259 says that JSON must be encoded using UTF-8. So,
      // we're going to explicitly decode using UTF-8... if we don't do this, then we can easily
      // end up with our JSON string containing incorrectly decoded characters.
      body = utf8.decode(response.bodyBytes);
    }

    return Response(response, _tryDecodeJson(body));
  }

  dynamic _tryDecodeJson(String data) {
    try {
      return json.decode(data);
    } catch (e) {
      logWarning(e);
      return data;
    }
  }

  @override
  FutureOr<Response> convertResponse(http.Response response) =>
      _decodeJson(response);

  @override
  FutureOr<Response> convertError(http.Response response) =>
      _decodeJson(response);
}
