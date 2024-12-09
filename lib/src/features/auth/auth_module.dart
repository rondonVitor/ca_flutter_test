import 'package:ca_flutter_test/src/shared/shared_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';

import 'ui/login_page.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        SharedModule(),
      ];

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child('/', child: (context) => LoginPage());
  }
}
