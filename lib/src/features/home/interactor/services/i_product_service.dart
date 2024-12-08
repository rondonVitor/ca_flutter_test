import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/features/home/interactor/entities/product_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract class IProductService {
  AsyncResult<List<ProductEntity>, BaseError> getAllProducts();
  AsyncResult<ProductEntity, BaseError> getproductById(int id);
}
