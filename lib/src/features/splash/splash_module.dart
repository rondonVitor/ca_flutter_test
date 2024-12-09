import 'package:ca_flutter_test/src/core/core_module.dart';
import 'package:ca_flutter_test/src/shared/shared_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'ui/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        SharedModule(),
      ];

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child('/', child: (context) => const SplashPage());
  }
}
