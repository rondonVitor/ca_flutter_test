import 'package:asp/asp.dart';
import 'package:ca_flutter_test/src/features/home/interactor/actions/home_actions.dart';
import 'package:ca_flutter_test/src/features/home/ui/favorite_products_page.dart';
import 'package:ca_flutter_test/src/features/home/ui/products_list_page.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/actions/user_actions.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/atoms/user_atoms.dart';
import 'package:ca_flutter_test/src/shared/user/interactor/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HookStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    getHomeProductsAction();
  }

  _userStateListener(UserEntity? user) {
    if (user == null) {
      Modular.to.navigate('/auth');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  final List<Widget> _pages = [
    const ProductsListPage(),
    const FavoriteProductsPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    useAtomEffect((get) => get(userState), effect: _userStateListener);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Conta Azul E-commerce',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              logoutAction();
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Favoritos',
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
