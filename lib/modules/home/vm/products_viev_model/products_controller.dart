import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/product.dart';
import '../../../../repositories/products_repository.dart';
part 'product_state.dart';

@immutable
class ProductsController implements Disposable {
  final ProductsApi productsApi;
  ProductsController(this.productsApi);

  final BehaviorSubject<ProductsState> _streamController =
      BehaviorSubject.seeded(const ProductsState());
  Stream<ProductsState> get stream => _streamController.stream;
  ProductsState get state => _streamController.value;

  Future<void> fetchAndSetProducts() async {
    _streamController.add(state.copyWith(status: ProductsStateLoad.loading));
    final List<Product> products = await productsApi.productsList();
    _streamController
        .add(state.copyWith(list: products, status: ProductsStateLoad.loaded));
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
