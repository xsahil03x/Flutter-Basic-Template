import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lumberdash/lumberdash.dart';
import 'api_errors.dart';

abstract class ApiBaseHelper {
  Future<Response<T>> get<T>(String url);

  Future<Response<T>> post<T>(String url, dynamic body);

  Future<Response<T>> put<T>(String url, dynamic body);

  Future<Response<T>> delete<T>(String url);
}

class ProdApiNetwork implements ApiBaseHelper {
  final String baseUrl;

  Dio _dio;

  final List<Interceptor> interceptors;

  ProdApiNetwork({
    @required this.baseUrl,
    this.interceptors,
    Dio dio,
  }) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = Duration(seconds: 60).inMilliseconds
      ..options.receiveTimeout = Duration(seconds: 60).inMilliseconds
      ..options.contentType = Headers.jsonContentType;
    if (interceptors?.isNotEmpty ?? false)
      _dio.interceptors.addAll(interceptors);
    if (kDebugMode)
      _dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }

  @override
  Future<Response<T>> get<T>(String url) async {
    try {
      return await _dio.get<T>('$baseUrl$url');
    } on SocketException {
      throw NetworkError();
    }
  }

  @override
  Future<Response<T>> post<T>(String url, body) async {
    try {
      return await _dio.post<T>('$baseUrl$url', data: body);
    } on SocketException {
      throw NetworkError();
    }
  }

  @override
  Future<Response<T>> delete<T>(String url) async {
    try {
      return await _dio.delete<T>('$baseUrl$url');
    } on SocketException {
      throw NetworkError();
    }
  }

  @override
  Future<Response<T>> put<T>(String url, body) async {
    try {
      return await _dio.put<T>('$baseUrl$url', data: body);
    } on SocketException {
      throw NetworkError();
    }
  }

/*  _parseResponse(Response response) {
    final code = response.statusCode;
    if (code >= 200 && code < 300) {
      return response;
    } else if (code == 401) {
      throw UnauthorizedError();
    } else if (code >= 400 && code < 500) {
      throw ClientError();
    } else if (code >= 500 && code < 600) {
      throw ServerError();
    }
  }*/
}

class DebugApiNetwork extends ProdApiNetwork {
  DebugApiNetwork({@required String baseUrl, List<Interceptor> interceptors})
      : super(baseUrl: baseUrl, interceptors: interceptors);
}

class MockApiNetwork implements ApiBaseHelper {
  @override
  Future<Response<T>> get<T>(String url) async {
    logMessage("calling get $url on Mock");
    switch (url) {
      default:
        throw new Exception("Not Implemented Yet :$url");
    }
  }

  @override
  Future<Response<T>> post<T>(String url, body) async {
    logMessage("calling post $url on Mock");
    switch (url) {
      default:
        throw new Exception("Not Implemented Yet :$url");
    }
  }

  @override
  Future<Response<T>> put<T>(String url, body) async {
    // TODO: implement put
    return null;
  }

  @override
  Future<Response<T>> delete<T>(String url) async {
    // TODO: implement delete
    return null;
  }

  Future<dynamic> _json(String path) async {
    await Future.delayed(Duration(seconds: 3));
    var res = await rootBundle.loadString(path);
    logMessage("Response for $path on Mock: $res");
    return await json.decode(res);
  }
}
