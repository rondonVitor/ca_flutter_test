import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/home/interactor/atoms/favorite_atoms.dart';
import 'package:ca_flutter_test/src/features/home/interactor/atoms/home_atoms.dart';
import 'package:ca_flutter_test/src/features/home/interactor/states/home_state.dart';

final likeProductAction = atomAction1<int>(
  (set, productId) async {
    final state = homeState.state;

    if (state is HomeSuccessState) {
      final index = state.products.indexWhere(
        (element) => element.id == productId,
      );

      state.products[index] = state.products[index].copyWith(
        isFavorite: !state.products[index].isFavorite,
      );

      set(homeState, HomeSuccessState(products: state.products));
      getFavoritesProductsAction();
    }
  },
);

final getFavoritesProductsAction = atomAction(
  (set) async {
    final state = homeState.state;

    if (state is HomeSuccessState) {
      final products = state.products
          .where(
            (element) => element.isFavorite == true,
          )
          .toList();

      set(favoriteProductsState, products);
    }
  },
);
