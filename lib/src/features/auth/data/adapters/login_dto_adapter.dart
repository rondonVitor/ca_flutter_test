import '../../interactor/dtos/login_dto.dart';

class LoginDtoAdapter {
  static Map<String, dynamic> toMap(LoginDTO loginDTO) {
    return <String, dynamic>{
      'username': loginDTO.username,
      'password': loginDTO.password,
    };
  }
}
