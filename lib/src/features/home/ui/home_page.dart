import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/home/interactor/actions/home_actions.dart';
import 'package:ca_flutter_test/src/features/home/interactor/atoms/home_atoms.dart';
import 'package:ca_flutter_test/src/features/home/interactor/states/home_state.dart';
import 'package:ca_flutter_test/src/features/home/ui/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HookStateMixin {
  @override
  void initState() {
    super.initState();

    getHomeProductsAction();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Conta Azul E-coommerce',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AtomBuilder(
        builder: (context, get) {
          final state = get(homeState);
          if (state is HomeErrorState) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      getHomeProductsAction();
                    },
                    child: const Text('aqui')),
                Center(
                  child: Text(
                    'Ocorreu um erro ao trazer os produtos, tente novamente mais tarde.',
                    style: textTheme.bodyLarge,
                  ),
                ),
              ],
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

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
