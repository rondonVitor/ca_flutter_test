import 'package:flutter_modular/flutter_modular.dart';

import 'ui/splash_page.dart';

class SplashModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child('/', child: (context) => const SplashPage());
  }
}
