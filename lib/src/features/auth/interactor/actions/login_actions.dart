import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../atoms/login_atoms.dart';
import '../../../../shared/auth/interactor/dtos/login_dto.dart';
import '../../../../shared/auth/interactor/services/i_auth_service.dart';
import '../states/login_state.dart';

final doLoginAction = atomAction2<String, String>(
  (set, username, password) async {
    set(loginState, LoginLoadingState());
    final service = Modular.get<IAuthService>();

    final result = await service.login(
      LoginDTO(
        username: username,
        password: password,
      ),
    );

    result.fold(
      (success) {
        set(loginState, LoginSuccessState());
      },
      (failure) {
        set(loginState, LoginErrorState(error: failure));
      },
    );
  },
);
