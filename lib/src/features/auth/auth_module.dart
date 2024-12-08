import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';
import 'data/services/auth_service.dart';
import 'interactor/services/i_auth_service.dart';
import 'ui/login_page.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    super.binds(i);

    i.add<IAuthService>(AuthService.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child('/', child: (context) => LoginPage());
  }
}
