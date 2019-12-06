import 'package:dairy/data/local/prefs/app_preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:lumberdash/lumberdash.dart';
import 'interceptor.dart';

enum LogLevel { BODY, HEADER, BASIC, NONE }

const String _requestHeader = '*****NETWORK REQUEST DATA*****';
const String _responseHeader = '*****NETWORK RESPONSE DATA*****';
const String _footer = '**--------*****---------END---------*****--------**';

class NetworkInterceptor implements RequestInterceptor, ResponseInterceptor {
  final LogLevel logLevel;
  final AppPreferencesHelper prefHelper;

  NetworkInterceptor({
    @required this.prefHelper,
    this.logLevel = LogLevel.BODY,
  });

  @override
  BaseRequest onInterceptRequest(BaseRequest request) {
    final token = prefHelper.getUserToken();
    if (token != null) {
      request.headers['Authorization'] = token;
    }
    switch (request.method) {
      case 'POST':
      case 'HEAD':
      case 'PUT':
      case 'GET':
        request.headers['Content-Type'] = 'application/json';
        break;
    }

    logMessage(
      '$_requestHeader\n'
      'METHOD: ${request.method}\n'
      'URL: ${request.url}\n'
      'HEADERS: ${request.headers}\n'
      '$_footer',
    );

    return request;
  }

  @override
  onInterceptResponse(Response response) {
    switch (logLevel) {
      case LogLevel.BODY:
        logMessage(
          '$_responseHeader\n'
          'STATUS: ${response.statusCode} ${response.reasonPhrase}\n'
          'URL: ${response.request.url}\n'
          'BODY: ${response.body}\n'
          '$_footer',
        );
        break;
      case LogLevel.HEADER:
        logMessage(
          '$_responseHeader\n'
          'STATUS: ${response.statusCode} ${response.reasonPhrase}\n'
          'URL: ${response.request.url}\n'
          'HEADERS: ${response.request.headers}'
          '$_footer',
        );
        break;
      case LogLevel.BASIC:
        logMessage(
          '$_responseHeader\n'
          'STATUS: ${response.statusCode} ${response.reasonPhrase}\n'
          'URL: ${response.request.url}'
          '$_footer',
        );
        break;
      case LogLevel.NONE:
        break;
    }
  }
}
