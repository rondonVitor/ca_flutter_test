import 'package:asp/asp.dart';
import 'package:asuka/asuka.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/actions/user_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../interactor/actions/login_actions.dart';
import '../interactor/atoms/login_atoms.dart';
import '../interactor/states/login_state.dart';

class LoginPage extends StatelessWidget with HookMixin {
  LoginPage({super.key});

  final usernameText = TextEditingController();
  final passwordText = TextEditingController();

  _loginStateListener(ILoginState state) {
    if (state is LoginSuccessState) {
      setUserStorageAction(
        usernameText.text,
        passwordText.text,
      );
      Modular.to.navigate('/home/');
    }

    if (state is LoginErrorState) {
      AsukaSnackbar.warning(state.error.message ?? '').show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final state = useAtomState(loginState);
    final isLoading = state is LoginLoadingState;

    useAtomEffect((get) => get(loginState), effect: _loginStateListener);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'SIGN IN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: usernameText,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordText,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    fixedSize: const Size(double.infinity, 46),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          doLoginAction(
                            usernameText.text,
                            passwordText.text,
                          );
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
