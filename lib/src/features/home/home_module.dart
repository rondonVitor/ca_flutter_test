import 'package:ca_flutter_test/src/features/home/data/services/product_service.dart';
import 'package:ca_flutter_test/src/features/home/interactor/services/i_product_service.dart';
import 'package:ca_flutter_test/src/features/home/ui/product_detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';
import 'ui/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    super.binds(i);

    i.add<IProductService>(ProductService.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child('/', child: (context) => const HomePage());
    r.child(
      '/product-detail',
      child: (context) => ProductDetailPage(
        product: r.args.data,
      ),
    );
  }
}
