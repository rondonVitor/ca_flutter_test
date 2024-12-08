import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../atoms/login_atoms.dart';
import '../dtos/login_dto.dart';
import '../services/i_auth_service.dart';
import '../states/login_state.dart';

final doLoginAction = atomAction1<LoginDTO>(
  (set, loginDTO) async {
    set(loginState, LoginLoadingState());
    final service = Modular.get<IAuthService>();

    final result = await service.login(loginDTO);

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
