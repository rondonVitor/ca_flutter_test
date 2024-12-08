import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/home/interactor/atoms/home_atoms.dart';
import 'package:ca_flutter_test/src/features/home/interactor/services/i_product_service.dart';
import 'package:ca_flutter_test/src/features/home/interactor/states/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

final getHomeProductsAction = atomAction(
  (set) async {
    set(homeState, HomeLoadingState());
    final service = Modular.get<IProductService>();

    final result = await service.getAllProducts();

    result.fold(
      (success) {
        set(homeState, HomeSuccessState(products: success));
      },
      (failure) {
        set(homeState, HomeErrorState(error: failure));
      },
    );
  },
);
