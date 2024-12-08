import 'package:flutter_modular/flutter_modular.dart';

import 'src/features/auth/auth_module.dart';
import 'src/features/home/home_module.dart';
import 'src/features/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: SplashModule());
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    super.routes(r);
  }
}
