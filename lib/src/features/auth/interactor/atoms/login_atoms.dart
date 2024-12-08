import 'package:asp/asp.dart';

import '../states/login_state.dart';

final loginState = atom<ILoginState>(
  LoginInitialState(),
);
