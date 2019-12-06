import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import '../interceptor/interceptor.dart';

class ApiClient extends BaseClient {
  final Client _inner;
  final List<BaseInterceptor> interceptors;

  ApiClient({
    Client inner,
    this.interceptors,
  }) : _inner = inner ?? IOClient();

  _interceptResponse(Response response) {
    interceptors?.forEach((interceptor) {
      if (interceptor is ResponseInterceptor)
        interceptor.onInterceptResponse(response);
    });
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    interceptors?.forEach((interceptor) {
      if (interceptor is RequestInterceptor)
        request = interceptor.onInterceptRequest(request) ?? request;
    });
    final response = _inner.send(request);
    return response;
  }

  @override
  Future<Response> head(url, {Map<String, String> headers}) async {
    final response = await super.head(url, headers: headers);
    _interceptResponse(response);
    return response;
  }

  @override
  Future<Response> get(url, {Map<String, String> headers}) async {
    final response = await super.get(url, headers: headers);
    _interceptResponse(response);
    return response;
  }

  @override
  Future<Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final response =
        await super.post(url, headers: headers, body: body, encoding: encoding);
    _interceptResponse(response);
    return response;
  }

  @override
  Future<Response> delete(url, {Map<String, String> headers}) async {
    final response = await super.delete(url, headers: headers);
    _interceptResponse(response);
    return response;
  }

  @override
  Future<Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final response =
        await super.put(url, headers: headers, body: body, encoding: encoding);
    _interceptResponse(response);
    return response;
  }
}
