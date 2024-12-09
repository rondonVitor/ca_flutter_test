import 'dart:convert';

import 'package:ca_flutter_test/src/core/http_service/client_response.dart';
import 'package:ca_flutter_test/src/core/http_service/http_service.dart';
import 'package:ca_flutter_test/src/shared/auth/data/adapters/login_dto_adapter.dart';
import 'package:ca_flutter_test/src/shared/auth/data/services/auth_service.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/dtos/login_dto.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/errors/auth_errors.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/services/i_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements IHttpService {}

void main() {
  final IHttpService mockHttp = MockHttpService();
  final IAuthService authService = AuthService(http: mockHttp);

  tearDown(
    () {
      reset(mockHttp);
    },
  );

  group(
    'AuthService | ',
    () {
      final loginDTO = LoginDTO(
        username: 'username',
        password: 'password',
      );
      test(
        'Should return TokenEntity when do login with success',
        () async {
          when(
            () => mockHttp.post(
              '/auth/login',
              data: jsonEncode(
                LoginDtoAdapter.toMap(loginDTO),
              ),
            ),
          ).thenAnswer(
            (_) => Future.value(
              const ClientResponse(
                data: {'token': "eyJhbGciOiJIUzI1NiIsInR"},
                statusCode: 200,
              ),
            ),
          );

          final result = await authService.login(loginDTO);

          expect(result.isSuccess(), true);
        },
      );

      test(
        'Should return UserNotFound when do login with error 500',
        () async {
          when(
            () => mockHttp.post(
              '/auth/login',
              data: jsonEncode(
                LoginDtoAdapter.toMap(loginDTO),
              ),
            ),
          ).thenAnswer(
            (_) => Future.value(
              const ClientResponse(
                data: [],
                statusCode: 500,
              ),
            ),
          );

          final result = await authService.login(loginDTO);

          expect(result.isError(), true);
          expect(result.exceptionOrNull(), isA<UserNotFound>());
        },
      );
    },
  );
}
