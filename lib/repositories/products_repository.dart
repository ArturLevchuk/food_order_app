import 'package:food_order_app/models/product.dart';

abstract interface class ProductsApi {
  Future<List<Product>> productsList();
}

class LocalProductsApi extends ProductsApi {
  @override
  Future<List<Product>> productsList() async {
    await Future.delayed(const Duration(seconds: 1));
    return allProducts;
  }
}
