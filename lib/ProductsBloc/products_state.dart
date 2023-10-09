part of 'products_bloc.dart';

enum ProductStateLoad { loading, loaded }

@immutable
class ProductsState {
  final List<Product> list;
  final ProductStateLoad status;

  const ProductsState(
      {this.list = const [], this.status = ProductStateLoad.loading});

  ProductsState copyWith({List<Product>? list, ProductStateLoad? status}) {
    return ProductsState(
        list: list ?? this.list, status: status ?? this.status);
  }
}
