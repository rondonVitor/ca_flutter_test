import 'package:uno/uno.dart';

import '../http_service.dart';

///Class to parse an [HttpResponseType] with [ResponseType]
class HttpResponseTypeAdapter {
  ///Method to convert an [HttpResponseType] to a [ResponseType]
  static ResponseType fromHttpResponseType(HttpResponseType responseType) {
    return ResponseType.values.firstWhere(
      (e) => e.name == responseType.name,
      orElse: () => ResponseType.json,
    );
  }
}
