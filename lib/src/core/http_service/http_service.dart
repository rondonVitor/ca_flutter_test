import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:uno/uno.dart';

import '../errors/base_error.dart';
import 'adapter/http_response_type_adapter.dart';
import 'client_response.dart';

enum HttpResponseType { json, plain, arraybuffer, stream }

/// Http protocol Interface
abstract class IHttpService {
  /// Aliase to `GET` method.
  Future<ClientResponse> get(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    HttpResponseType responseType = HttpResponseType.json,
    Function(int, int)? onDownloadProgress,
  });

  /// Aliase to `POST` method.
  Future<ClientResponse> post(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  });

  /// Aliase to `Delete` method.
  Future<ClientResponse> delete(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  });

  /// Aliase to `PUT` method.
  Future<ClientResponse> put(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  });

  /// Aliase to `patch` method.
  Future<ClientResponse> patch(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  });
}

class HttpService implements IHttpService {
  final Uno _uno;
  final Connectivity _connectivity;

  final defaultHeader = {
    'Content-Type': 'application/json',
  };

  HttpService(
    this._uno,
    this._connectivity,
  ) {
    _uno.interceptors.request.use(interceptRequest);
    _uno.interceptors.response.use(interceptResponse, onError: interceptError);
  }

  @override
  Future<ClientResponse> get(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    HttpResponseType responseType = HttpResponseType.json,
    Function(int, int)? onDownloadProgress,
  }) {
    return _fetch(
      () => _uno.get(
        url,
        params: params,
        headers: {...headers, ...defaultHeader},
        responseType:
            HttpResponseTypeAdapter.fromHttpResponseType(responseType),
        onDownloadProgress: onDownloadProgress,
      ),
    );
  }

  @override
  Future<ClientResponse> post(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  }) async {
    return _fetch(() {
      return _uno.post(
        url,
        data: data,
        params: params,
        headers: {...headers, ...defaultHeader},
        responseType:
            HttpResponseTypeAdapter.fromHttpResponseType(responseType),
      );
    });
  }

  @override
  Future<ClientResponse> put(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  }) {
    return _fetch(() {
      return _uno.put(
        url,
        data: data,
        params: params,
        headers: {...headers, ...defaultHeader},
        responseType:
            HttpResponseTypeAdapter.fromHttpResponseType(responseType),
      );
    });
  }

  @override
  Future<ClientResponse> delete(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  }) {
    return _fetch(() {
      return _uno.delete(
        url,
        data: data,
        params: params,
        headers: {...headers, ...defaultHeader},
        responseType:
            HttpResponseTypeAdapter.fromHttpResponseType(responseType),
      );
    });
  }

  Future<ClientResponse> _fetch(Future<Response> Function() fn) async {
    try {
      final response = await fn();

      return ClientResponse(
        data: response.data,
        statusCode: response.status,
      );
    } on UnoError catch (error) {
      throw HttpError(
        message: error.message,
        statusCode: error.response?.status,
        data: error.response?.data,
        stackTrace: error.stackTrace,
      );
    }
  }

  @override
  Future<ClientResponse> patch(
    String url, {
    Map<String, String> params = const {},
    Map<String, String> headers = const {},
    dynamic data,
    HttpResponseType responseType = HttpResponseType.json,
  }) {
    return _fetch(() {
      return _uno.patch(
        url,
        data: data,
        params: params,
        headers: {...headers, ...defaultHeader},
        responseType:
            HttpResponseTypeAdapter.fromHttpResponseType(responseType),
      );
    });
  }

  FutureOr<Request> interceptRequest(Request request) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.wifi)) {
      throw NetworkError();
    }

    return request;
  }

  FutureOr<Response> interceptResponse(Response response) async {
    return response;
  }

  FutureOr interceptError(UnoError unoError) async {
    debugPrint('URL -> ${unoError.request?.uri.path}');
    debugPrint('MESSAGE -> ${unoError.message}');
    if (unoError.response == null) {
      return await interceptResponse(
        Response(
          headers: {},
          request: unoError.request!,
          status: 500,
          data: {},
        ),
      );
    }
    return unoError;
  }
}
