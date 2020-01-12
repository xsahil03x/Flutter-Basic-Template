import 'package:dio/dio.dart';

class ServerError extends DioError {}

class ClientError extends DioError {}

class NetworkError extends DioError {}

class UnauthorizedError extends DioError {}