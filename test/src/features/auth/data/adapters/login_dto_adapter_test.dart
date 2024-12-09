import 'package:ca_flutter_test/src/shared/auth/data/adapters/login_dto_adapter.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/dtos/login_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'LoginDtoAdapter |',
    () {
      test(
        'Should adapt LoginDTO to Map<String, dynamic> with success',
        () {
          final loginDTO = LoginDTO(username: 'username', password: 'password');

          Map<String, dynamic> mapResult = {
            'username': 'username',
            'password': 'password'
          };

          final result = LoginDtoAdapter.toMap(loginDTO);

          expect(result, equals(mapResult));
        },
      );
    },
  );
}
