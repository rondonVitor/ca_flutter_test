import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/features/auth/data/adapters/token_entity_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'TokenEntityAdapter |',
    () {
      test(
        'Should adapt Map<String, dynamic> to TokenEntity with success',
        () {
          Map<String, dynamic> map = {
            'token': 'token',
          };

          final result = TokenEntityAdapter.fromMap(map);

          expect(result.token, 'token');
        },
      );

      test(
        'Should throw AdapterError when adapt Map<String, dynamic> to TokenEntity with error',
        () {
          Map<String, dynamic> map = {
            'token-error': 'token',
          };

          expect(
            () => TokenEntityAdapter.fromMap(map),
            throwsA(isA<AdapterError>()),
          );
        },
      );
    },
  );
}
