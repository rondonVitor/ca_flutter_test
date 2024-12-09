import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/atoms/user_atoms.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/entities/user_entity.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/services/i_user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

final setUserStorageAction = atomAction2<String, String>(
  (set, username, password) async {
    final service = Modular.get<IUserService>();

    await service.setUser(
      UserEntity(
        username: username,
        password: password,
      ),
    );
  },
);

final getUserStorageAction = atomAction(
  (set) async {
    final service = Modular.get<IUserService>();

    final response = await service.getUser();

    response.fold(
      (success) {
        set(userState, success);
      },
      (failure) {
        set(userState, UserEntity(username: '', password: ''));
      },
    );
  },
);

final logoutAction = atomAction(
  (set) async {
    final service = Modular.get<IUserService>();

    final response = await service.deleteUser();

    response.fold(
      (success) {
        set(userState, null);
      },
      (failure) {
        set(userState, userState);
      },
    );
  },
);
