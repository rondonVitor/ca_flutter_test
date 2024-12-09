import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uno/uno.dart';

import 'http_service/http_factory.dart';
import 'http_service/http_service.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);

    i.addSingleton<Uno>(
        () => HttpFactory.createUno(baseUrl: 'https://fakestoreapi.com'));
    i.add<Connectivity>(Connectivity.new);
    i.addSingleton<IHttpService>(HttpService.new);
    i.add<FlutterSecureStorage>(FlutterSecureStorage.new);
  }
}
