import 'package:uno/uno.dart';

///Uno factory
class HttpFactory {
  ///Method to create an instance of [Uno]
  static Uno createUno({required String baseUrl}) {
    return Uno(baseURL: baseUrl);
  }
}
