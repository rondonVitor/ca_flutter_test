import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/features/auth/interactor/actions/login_actions.dart';
import 'package:ca_flutter_test/src/features/auth/interactor/atoms/login_atoms.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/dtos/login_dto.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/entities/token_entity.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/services/i_auth_service.dart';
import 'package:ca_flutter_test/src/features/auth/interactor/states/login_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class AuthServiceMock extends Mock implements IAuthService {}

class ModuleTest extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<IAuthService>(AuthServiceMock.new);
  }
}

void main() {
  Modular.bindModule(ModuleTest());

  group(
    'LoginActions |',
    () {
      test(
        'Should set LoginSuccessState in loginState when do login successfully',
        () {
          final authServiceMock = Modular.get<IAuthService>();

          final loginDTO = LoginDTO(
            username: 'username',
            password: 'password',
          );

          when(
            () => authServiceMock.login(loginDTO),
          ).thenAnswer(
            (_) => Future.value(
              Success(
                TokenEntity(token: 'token'),
              ),
            ),
          );

          expect(
            loginState.buffer(2),
            completion(
              [isA<LoginLoadingState>(), isA<LoginSuccessState>()],
            ),
          );

          doLoginAction(
            loginDTO.username,
            loginDTO.password,
          );
        },
      );

      test(
        'Should set LoginErrorState in loginState when do login with error',
        () {
          final authServiceMock = Modular.get<IAuthService>();

          final loginDTO = LoginDTO(
            username: '',
            password: '',
          );

          when(
            () => authServiceMock.login(loginDTO),
          ).thenAnswer(
            (_) => Future.value(
              Failure(
                UnknownError(),
              ),
            ),
          );

          expect(
            loginState.buffer(2),
            completion(
              [isA<LoginLoadingState>(), isA<LoginErrorState>()],
            ),
          );

          doLoginAction(
            loginDTO.username,
            loginDTO.password,
          );
        },
      );
    },
  );
}
