///Interface of project's base error
abstract class BaseError implements Exception {
  ///Message of error
  final String? message;

  ///StackTrace of error
  final StackTrace? stackTrace;

  ///Code of error
  final String code;

  ///Base constructor of [BaseError]
  BaseError({
    required this.code,
    this.message,
    this.stackTrace,
  });

  @override
  String toString() {
    var value = '$runtimeType: $message';
    if (stackTrace != null) {
      value += '\n$stackTrace';
    }
    return value;
  }
}

///Error used when something goes totally off the mark in adapters
class AdapterError extends BaseError {
  ///Base constructor of [AdapterError]
  AdapterError({
    super.message = 'Ocorreu um erro, tente novamente mais tarde.',
    required super.code,
    super.stackTrace,
  });
}

///Error used when something goes totally off the mark in network request errors
class NetworkError extends BaseError {
  ///Base constructor of [NetworkError]
  NetworkError({
    super.message =
        'Verifique a conexão com a internet, tente novamente mais tarde.',
    super.code = 'Internet Erorr',
    super.stackTrace,
  });
}

///Error used when something goes totally off the mark in http request errors
class HttpError extends BaseError {
  final int? statusCode;
  final dynamic data;
  HttpError({
    required super.message,
    super.stackTrace,
    super.code = '',
    required this.data,
    this.statusCode = 500,
  });
}

///Error used when something goes totally off the mark
class UnknownError extends BaseError {
  ///Base constructor of [UnknownError]
  UnknownError({
    super.message = 'Ocorreu um erro, tente novamente mais tarde.',
    super.stackTrace,
  }) : super(code: 'unknown-error');
}
