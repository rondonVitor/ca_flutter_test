import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/entities/user_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract class IUserService {
  AsyncResult<Unit, BaseError> setUser(UserEntity user);
  AsyncResult<UserEntity, BaseError> getUser();
  AsyncResult<Unit, BaseError> deleteUser();
}
