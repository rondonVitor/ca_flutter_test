import 'package:ca_flutter_test/src/core/errors/base_error.dart';
import 'package:ca_flutter_test/src/features/home/interactor/entities/product_entity.dart';

sealed class IHomeState {}

class HomeInitialState extends IHomeState {}

class HomeLoadingState extends IHomeState {}

class HomeErrorState extends IHomeState {
  final BaseError error;

  HomeErrorState({
    required this.error,
  });
}

class HomeSuccessState extends IHomeState {
  final List<ProductEntity> products;

  HomeSuccessState({
    required this.products,
  });
}
