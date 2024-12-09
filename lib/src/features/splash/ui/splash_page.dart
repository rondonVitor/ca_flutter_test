import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/auth/interactor/actions/login_actions.dart';
import 'package:ca_flutter_test/src/features/auth/interactor/atoms/login_atoms.dart';
import 'package:ca_flutter_test/src/features/auth/interactor/states/login_state.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/actions/user_actions.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/atoms/user_atoms.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/constants/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with HookStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400)).then(
      (value) {
        setState(() {
          _visible = true;
        });
      },
    );
  }

  void _onAnimationEnd() {
    getUserStorageAction();
  }

  _userStateListener(UserEntity? user) {
    if (user != null && user.username != '' && user.password != '') {
      doLoginAction(user.username, user.password);
    } else {
      Modular.to.navigate('/auth/');
    }
  }

  _loginStateListener(ILoginState state) {
    if (state is LoginSuccessState) {
      Modular.to.navigate('/home/');
    }

    if (state is LoginErrorState) {
      Modular.to.navigate('/auth/');
    }
  }

  @override
  Widget build(BuildContext context) {
    useAtomEffect((get) => get(userState), effect: _userStateListener);
    useAtomEffect((get) => get(loginState), effect: _loginStateListener);

    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(seconds: 2),
          onEnd: () {
            _onAnimationEnd();
          },
          child: Image.asset(
            AppImages.logo,
          ),
        ),
      ),
    );
  }
}
