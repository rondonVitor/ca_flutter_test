import 'package:ca_flutter_test/src/features/home/interactor/entities/product_entity.dart';

import '../../../../core/errors/base_error.dart';

class ProductEntityAdapter {
  static ProductEntity fromMap(Map<String, dynamic> map) {
    try {
      return ProductEntity(
        id: map['id'],
        title: map['title'],
        price: map['price'].toString(),
        category: map['category'],
        description: map['description'],
        imageUrl: map['image'],
        isFavorite: false,
      );
    } catch (e) {
      throw AdapterError(
        code: 'product-entity-adapter',
      );
    }
  }

  static List<ProductEntity> fromMapList(List<dynamic> mapList) {
    try {
      final model = mapList
          .map(
            (e) => fromMap(e),
          )
          .toList();

      return model;
    } catch (e) {
      throw AdapterError(
        code: 'product-entity-adapter',
      );
    }
  }
}
