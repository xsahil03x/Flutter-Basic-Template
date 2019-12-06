import 'package:dairy/data/remote/api_client/response.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

@immutable
abstract class Converter {
  FutureOr<Response> convertResponse(http.Response response);
}

@immutable
abstract class ErrorConverter {
  FutureOr<Response> convertError(http.Response response);
}
