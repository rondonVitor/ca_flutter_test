// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/core/http_service/http_service.dart';
import 'package:ca_flutter_test/src/shared/auth/data/adapters/login_dto_adapter.dart';
import 'package:ca_flutter_test/src/shared/auth/data/adapters/token_entity_adapter.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/dtos/login_dto.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/entities/token_entity.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/errors/auth_errors.dart';
import 'package:ca_flutter_test/src/shared/auth/interactor/services/i_auth_service.dart';
import 'package:result_dart/result_dart.dart';

class AuthService implements IAuthService {
  final IHttpService http;

  AuthService({
    required this.http,
  });

  @override
  AsyncResult<TokenEntity, BaseError> login(LoginDTO loginDTO) async {
    try {
      final data = LoginDtoAdapter.toMap(loginDTO);
      final response = await http.post(
        '/auth/login',
        data: jsonEncode(data),
      );

      if (response.statusCode == 500) {
        throw UserNotFound();
      }

      return Success(TokenEntityAdapter.fromMap(response.data));
    } on BaseError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownError(),
      );
    }
  }
}
