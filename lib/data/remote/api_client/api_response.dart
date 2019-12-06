import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'response.dart';

enum _ApiResponse {
  Success,
  Unauthenticated,
  ClientError,
  ServerError,
  NetworkError,
  UnexpectedError,
}

@sealed
@immutable
abstract class ApiResponse extends Equatable {
  const ApiResponse(this._type);

  factory ApiResponse.success({@required Response response}) = Success;

  factory ApiResponse.unauthenticated({@required Response response}) =
      Unauthenticated;

  factory ApiResponse.clientError({@required Response response}) = ClientError;

  factory ApiResponse.serverError({@required Response response}) = ServerError;

  factory ApiResponse.networkError({@required SocketException e}) =
      NetworkError;

  factory ApiResponse.unexpectedError({@required Exception e}) =
      UnexpectedError;

  final _ApiResponse _type;

  /// Returns `true` if this instance represents successful outcome.
  /// In this case [isFailure] returns `false`.
  bool get isSuccess => _type == _ApiResponse.Success;

  /// Returns `true` if this instance represents failed outcome.
  /// In this case [isSuccess] returns `false`.
  bool get isFailure => _type != _ApiResponse.Success;

//ignore: missing_return
  R when<R>({
    @required R Function(Success) success,
    @required R Function(Unauthenticated) unauthenticated,
    @required R Function(ClientError) clientError,
    @required R Function(ServerError) serverError,
    @required R Function(NetworkError) networkError,
    @required R Function(UnexpectedError) unexpectedError,
  }) {
    switch (this._type) {
      case _ApiResponse.Success:
        return success(this as Success);
      case _ApiResponse.Unauthenticated:
        return unauthenticated(this as Unauthenticated);
      case _ApiResponse.ClientError:
        return clientError(this as ClientError);
      case _ApiResponse.ServerError:
        return serverError(this as ServerError);
      case _ApiResponse.NetworkError:
        return networkError(this as NetworkError);
      case _ApiResponse.UnexpectedError:
        return unexpectedError(this as UnexpectedError);
    }
  }

  /// Returns the encapsulated value if this instance represents [success][ApiResponse.isSuccess] or the
  /// result of [onFailure] function for encapsulated exception if it is [failure][ApiResponse.isFailure].
  ApiResponse getOrElse(ApiResponse Function(ApiResponse) onFailure) {
    if (isSuccess) {
      return this as Success;
    } else {
      return onFailure(_getError);
    }
  }

  R whenOrElse<R extends ApiResponse>(Function(ApiResponse) run,
      {Function(dynamic) orElse}) {
    switch (this._type) {
      case _ApiResponse.Success:
        if (R == Success) return run(this as Success);
        return orElse(this);
      case _ApiResponse.Unauthenticated:
        if (R == Unauthenticated) return run(this as Unauthenticated);
        return orElse(this);
      case _ApiResponse.ClientError:
        if (R == ClientError) return run(this as ClientError);
        return orElse(this);
      case _ApiResponse.ServerError:
        if (R == ServerError) return run(this as ServerError);
        return orElse(this);
      case _ApiResponse.NetworkError:
        if (R == NetworkError) return run(this as NetworkError);
        return orElse(this);
      case _ApiResponse.UnexpectedError:
        if (R == UnexpectedError) return run(this as UnexpectedError);
        return orElse(this);
    }
  }

  /// Returns the encapsulated value if this instance represents [success][ApiResponse.isSuccess] or the
  /// [defaultValue] if it is [failure][ApiResponse.isFailure].
  ///
  /// This function is shorthand for `getOrElse((e) => defaultValue)` (see [getOrElse]).
  ApiResponse getOrDefault(ApiResponse defaultValue) {
    if (isFailure) return defaultValue;
    return this as Success;
  }

  Success getSuccessData() {
    if (isSuccess) {
      return this as Success;
    } else
      return null;
  }

  /// Performs the given [action] on encapsulated value if this instance represents [success].
  /// Returns the original `Result` unchanged.
  ApiResponse onSuccess(void action(Success value)) {
    if (isSuccess) {
      action(this as Success);
    }
    return this;
  }

  ApiResponse get _getError {
    switch (_type) {
      case _ApiResponse.Unauthenticated:
        return this as Unauthenticated;
      case _ApiResponse.ClientError:
        return this as ClientError;
      case _ApiResponse.ServerError:
        return this as ServerError;
      case _ApiResponse.NetworkError:
        return this as NetworkError;
      case _ApiResponse.UnexpectedError:
        return this as UnexpectedError;
      default:
        return this;
    }
  }

  @override
  List get props => null;
}

@immutable
class Success extends ApiResponse {
  const Success({@required this.response}) : super(_ApiResponse.Success);

  final Response response;

  @override
  String toString() => 'Success(response:${this.response})';

  @override
  List get props => [response];
}

@immutable
class Unauthenticated extends ApiResponse {
  const Unauthenticated({@required this.response})
      : super(_ApiResponse.Unauthenticated);

  final Response response;

  @override
  String toString() => 'Unauthenticated(response:${this.response})';

  @override
  List get props => [response];
}

@immutable
class ClientError extends ApiResponse {
  const ClientError({@required this.response})
      : super(_ApiResponse.ClientError);

  final Response response;

  @override
  String toString() => 'ClientError(response:${this.response})';

  @override
  List get props => [response];
}

@immutable
class ServerError extends ApiResponse {
  const ServerError({@required this.response})
      : super(_ApiResponse.ServerError);

  final Response response;

  @override
  String toString() => 'ServerError(response:${this.response})';

  @override
  List get props => [response];
}

@immutable
class NetworkError extends ApiResponse {
  const NetworkError({@required this.e}) : super(_ApiResponse.NetworkError);

  final SocketException e;

  @override
  String toString() => 'NetworkError(e:${this.e})';

  @override
  List get props => [e];
}

@immutable
class UnexpectedError extends ApiResponse {
  const UnexpectedError({@required this.e})
      : super(_ApiResponse.UnexpectedError);

  final Exception e;

  @override
  String toString() => 'UnexpectedError(f:${this.e})';

  @override
  List get props => [e];
}
