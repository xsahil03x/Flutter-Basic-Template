import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

@immutable
abstract class BaseInterceptor {}

@immutable
abstract class ResponseInterceptor extends BaseInterceptor {
  onInterceptResponse(Response response);
}

@immutable
abstract class RequestInterceptor extends BaseInterceptor {
  BaseRequest onInterceptRequest(BaseRequest request);
}
