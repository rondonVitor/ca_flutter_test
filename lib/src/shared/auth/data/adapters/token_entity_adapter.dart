import '../../../../core/errors/base_error.dart';
import '../../interactor/entities/token_entity.dart';

class TokenEntityAdapter {
  static TokenEntity fromMap(Map<String, dynamic> map) {
    try {
      return TokenEntity(
        token: map['token'],
      );
    } catch (e) {
      throw AdapterError(
        code: 'login-dto-adapter',
      );
    }
  }
}
