part of 'products_controller.dart';

enum ProductsStateLoad { init, loading, loaded }

@immutable
class ProductsState {
  final List<Product> list;
  final ProductsStateLoad status;

  const ProductsState(
      {this.list = const [], this.status = ProductsStateLoad.init});

  ProductsState copyWith({List<Product>? list, ProductsStateLoad? status}) {
    return ProductsState(
        list: list ?? this.list, status: status ?? this.status);
  }

  List<Product> productsByType(ProductType type) {
    return list.where((element) => element.productType == type).toList();
  }
}
