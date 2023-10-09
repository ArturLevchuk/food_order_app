import 'package:bloc/bloc.dart';
import 'package:food_order_app/models/product.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const ProductsState()) {
    on<FetchAndLoadProducts>(_onFetchAndLoadProducts);
  }

  void _onFetchAndLoadProducts(
    FetchAndLoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    final loadedProducts = allProducts;
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(list: loadedProducts, status: ProductStateLoad.loaded));
  }
}
