import 'package:food_order_app/ProductsBloc/products_bloc.dart';
import 'package:food_order_app/models/cart_item.dart';

import '../models/product.dart';

class CartRepository {
  final CartApi cartApi;

  CartRepository({required this.cartApi});

  Future<List<CartItem>> loadCartItems(ProductsBloc bloc) async {
    final cartData = await cartApi.getCartList();
    return cartData.map((cartMap) {
      final productId = cartMap['productId'];
      late Product product;
      if (bloc.state.status != ProductStateLoad.init &&
          bloc.state.list.any((element) => element.id == productId)) {
        product =
            bloc.state.list.firstWhere((element) => element.id == productId);
      } else {
        //TODO: http reauest for product
      }
      return CartItem(
        cartId: cartMap['cartId'],
        count: int.parse(cartMap['count']),
        product: product,
        additives: cartMap['additives'],
        size: cartMap['size'],
      );
    }).toList();
  }

  Future<void> addToCart(CartItem cartItem) async {
    return cartApi.addToCart();
  }

  Future<void> removeFromCart(String id) async {
    return cartApi.removeFromCart(id);
  }
}

abstract interface class CartApi {
  Future<List<Map<String, dynamic>>> getCartList();
  Future<void> addToCart();
  Future<void> removeFromCart(String id);
}

class FirebaseCartApi implements CartApi {
  @override
  Future<List<Map<String, dynamic>>> getCartList() async {
    //TODO: http request to get items
    return cartItems;
  }

  @override
  Future<void> addToCart() async {
    //TODO: add to cart
  }

  @override
  Future<void> removeFromCart(String id) async {
    //TODO: remove from cart
  }
}
