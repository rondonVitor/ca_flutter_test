import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/home/interactor/actions/favorite_actions.dart';
import 'package:ca_flutter_test/src/features/home/interactor/atoms/favorite_atoms.dart';
import 'package:ca_flutter_test/src/features/home/ui/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoriteProductsPage extends StatefulWidget {
  const FavoriteProductsPage({super.key});

  @override
  State<FavoriteProductsPage> createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {
  @override
  void initState() {
    super.initState();

    getFavoritesProductsAction();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AtomBuilder(
        builder: (context, get) {
          final state = get(favoriteProductsState);
          if (state.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Não tem nenhum produto favorito, favorite algum produto e volte aqui!',
                  style: textTheme.bodyLarge,
                ),
              ),
            );
          }

          if (state.isNotEmpty) {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Modular.to
                        .pushNamed('./product-detail', arguments: state[index]);
                  },
                  child: ProductCardWidget(
                    product: state[index],
                  ),
                );
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
