import 'package:ca_flutter_test/src/core/core_module.dart';
import 'package:ca_flutter_test/src/shared/auth/data/services/auth_service.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/services/i_auth_service.dart';
import 'package:ca_flutter_test/src/shared/user/data/services/user_service.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/services/i_user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SharedModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);

    i.add<IUserService>(UserService.new);
    i.add<IAuthService>(AuthService.new);
  }
}
