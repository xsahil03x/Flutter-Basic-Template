import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dairy/data/remote/api_client/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:http/http.dart' as http;
import 'api_client/api_response.dart';
import 'interceptor/interceptor.dart';
import 'api_client/response.dart';
import 'converter/converter.dart';

abstract class ApiBaseHelper {
  Future<ApiResponse> get(String url);

  Future<ApiResponse> post(String url, dynamic body);

  Future<ApiResponse> put(String url, dynamic body);

  Future<ApiResponse> delete(String url);
}

class ProdApiNetwork implements ApiBaseHelper {
  final String baseUrl;

  final Converter converter;

  ApiClient _client;

  final List<BaseInterceptor> interceptors;

  ProdApiNetwork({
    @required this.baseUrl,
    @required this.converter,
    this.interceptors,
  }) {
    _client = interceptors != null
        ? ApiClient(interceptors: interceptors)
        : ApiClient();
  }

  @override
  Future<ApiResponse> get(String url) async {
    try {
      final response = await _client.get('$baseUrl$url');
      return await _parseResponse(response);
    } on SocketException catch (e) {
      return ApiResponse.networkError(e: e);
    } catch (e) {
      return ApiResponse.unexpectedError(e: e);
    }
  }

  @override
  Future<ApiResponse> post(String url, body) async {
    try {
      final response = await _client.post('$baseUrl$url', body: body);
      return await _parseResponse(response);
    } on SocketException catch (e) {
      return ApiResponse.networkError(e: e);
    } catch (e) {
      return ApiResponse.unexpectedError(e: e);
    }
  }

  @override
  Future<ApiResponse> put(String url, body) async {
    try {
      final response = await _client.put('$baseUrl$url', body: body);
      return await _parseResponse(response);
    } on SocketException catch (e) {
      return ApiResponse.networkError(e: e);
    } catch (e) {
      return ApiResponse.unexpectedError(e: e);
    }
  }

  @override
  Future<ApiResponse> delete(String url) async {
    try {
      final response = await _client.delete('$baseUrl$url');
      return await _parseResponse(response);
    } on SocketException catch (e) {
      return ApiResponse.networkError(e: e);
    } catch (e) {
      return ApiResponse.unexpectedError(e: e);
    }
  }

  Future<ApiResponse> _parseResponse(http.Response response) async {
    final code = response.statusCode;
    if (code >= 200 && code < 300) {
      return ApiResponse.success(
        response: await _decodeResponse(response, converter),
      );
    } else if (code == 401) {
      return ApiResponse.unauthenticated(
        response: await _decodeResponse(response, converter),
      );
    } else if (code >= 400 && code < 500) {
      return ApiResponse.clientError(
        response: await _decodeResponse(response, converter),
      );
    } else if (code >= 500 && code < 600) {
      return ApiResponse.serverError(
        response: await _decodeResponse(response, converter),
      );
    } else {
      return ApiResponse.unexpectedError(
        e: HttpException('Unexpected response $response'),
      );
    }
  }

  Future<Response> _decodeResponse(
    http.Response response,
    Converter withConverter,
  ) async {
    if (withConverter == null) return Response(response, response.body);

    final converted = await withConverter.convertResponse(response);

    if (converted == null) {
      throw Exception("No converter found for ${response.body}");
    }

    return converted;
  }
}

class DebugApiNetwork extends ProdApiNetwork {
  DebugApiNetwork(String baseUrl, Converter converter)
      : super(baseUrl: baseUrl, converter: converter);
}

class MockApiNetwork implements ApiBaseHelper {
  @override
  Future<ApiResponse> get(String url) async {
    logMessage("calling get $url on Mock");
    switch (url) {
      default:
        throw new Exception("Not Implemented Yet :$url");
    }
  }

  @override
  Future<ApiResponse> post(String url, body) async {
    logMessage("calling post $url on Mock");
    switch (url) {
      default:
        throw new Exception("Not Implemented Yet :$url");
    }
  }

  @override
  Future<ApiResponse> put(String url, body) async {
    // TODO: implement put
    return null;
  }

  @override
  Future<ApiResponse> delete(String url) async {
    // TODO: implement delete
    return null;
  }

  Future<ApiResponse> _json(String path) async {
    await Future.delayed(Duration(seconds: 3));
    var res = await rootBundle.loadString(path);
    logMessage("Response for $path on Mock: $res");
    return await json.decode(res);
  }
}
