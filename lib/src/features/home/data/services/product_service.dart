import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/core/http_service/http_service.dart';
import 'package:ca_flutter_test/src/features/home/data/adapters/product_entity_adapter.dart';
import 'package:ca_flutter_test/src/features/home/interactor/entities/product_entity.dart';
import 'package:ca_flutter_test/src/features/home/interactor/services/i_product_service.dart';
import 'package:result_dart/result_dart.dart';

class ProductService implements IProductService {
  final IHttpService http;

  ProductService({
    required this.http,
  });

  @override
  AsyncResult<List<ProductEntity>, BaseError> getAllProducts() async {
    try {
      final response = await http.get(
        '/products',
      );

      return Success(ProductEntityAdapter.fromMapList(response.data));
    } on BaseError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownError(),
      );
    }
  }

  @override
  AsyncResult<ProductEntity, BaseError> getproductById(int id) async {
    try {
      final response = await http.get(
        '/products/$id',
      );

      return Success(ProductEntityAdapter.fromMap(response.data));
    } on BaseError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnknownError(),
      );
    }
  }
}
