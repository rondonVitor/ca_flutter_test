import 'dart:convert';

import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/shared/user/data/adapters/user_entity_adapter.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/entities/user_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ca_flutter_test/src/shared/user/interactor/services/i_user_service.dart';
import 'package:result_dart/result_dart.dart';

class UserService implements IUserService {
  final FlutterSecureStorage flutterSecureStorage;

  UserService({
    required this.flutterSecureStorage,
  });

  @override
  AsyncResult<UserEntity, BaseError> getUser() async {
    String? user = await flutterSecureStorage.read(key: 'user');

    if (user != null) {
      final userDecoded = jsonDecode(user) as Map<String, dynamic>;

      return Result.success(
        UserEntityAdapter.fromMap(
          userDecoded,
        ),
      );
    }

    return Result.failure(UnknownError());
  }

  @override
  AsyncResult<Unit, BaseError> setUser(UserEntity user) async {
    await flutterSecureStorage.write(
        key: 'user', value: jsonEncode(UserEntityAdapter.toMap(user)));

    return const Result.success(unit);
  }

  @override
  AsyncResult<Unit, BaseError> deleteUser() async {
    await flutterSecureStorage.delete(key: 'user');

    return const Result.success(unit);
  }
}
