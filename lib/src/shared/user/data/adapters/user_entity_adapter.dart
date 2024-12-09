import 'package:ca_flutter_test/src/shared/user/interactor/entities/user_entity.dart';

class UserEntityAdapter {
  static UserEntity fromMap(Map<String, dynamic> map) {
    return UserEntity(
      username: map['username'],
      password: map['password'],
    );
  }

  static Map<String, dynamic> toMap(UserEntity user) {
    return {
      'username': user.username,
      'password': user.password,
    };
  }
}
