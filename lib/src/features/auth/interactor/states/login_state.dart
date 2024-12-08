import '../../../../core/errors/base_error.dart';

sealed class ILoginState {}

class LoginInitialState implements ILoginState {}

class LoginLoadingState implements ILoginState {}

class LoginErrorState implements ILoginState {
  final BaseError error;

  const LoginErrorState({required this.error});
}

class LoginSuccessState implements ILoginState {}
