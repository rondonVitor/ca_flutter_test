import 'package:result_dart/result_dart.dart';

import '../../../../core/errors/base_error.dart';
import '../dtos/login_dto.dart';
import '../entities/token_entity.dart';

abstract class IAuthService {
  AsyncResult<TokenEntity, BaseError> login(LoginDTO loginDTO);
}
