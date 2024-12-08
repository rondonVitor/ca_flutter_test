import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/home/interactor/states/home_state.dart';

final homeState = atom<IHomeState>(
  HomeInitialState(),
);
