import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/home/interactor/atoms/home_atoms.dart';
import 'package:ca_flutter_test/src/features/home/interactor/states/home_state.dart';
import 'package:ca_flutter_test/src/features/home/ui/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AtomBuilder(
        builder: (context, get) {
          final state = get(homeState);
          if (state is HomeErrorState) {
            return Center(
              child: Text(
                'Ocorreu um erro ao trazer os produtos, tente novamente mais tarde.',
                style: textTheme.bodyLarge,
              ),
            );
          }

          if (state is HomeSuccessState) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed('./product-detail',
                        arguments: state.products[index]);
                  },
                  child: ProductCardWidget(
                    product: state.products[index],
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
