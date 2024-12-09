import '../../../../core/errors/base_error.dart';

class UserNotFound extends BaseError {
  UserNotFound({super.message = 'Usuário não encontrado', super.code = '500'});
}
