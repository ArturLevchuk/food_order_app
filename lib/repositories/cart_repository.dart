import '../models/cart_item.dart';

class CartRepository {
  final CartApi cartApi;

  CartRepository({required this.cartApi});

  Future<List<CartItem>> loadCartItems() async {
    return cartApi.getCartList();
  }

  Future<void> addToCart(CartItem cartItem) async {
    return cartApi.addToCart(cartItem);
  }

  Future<void> removeFromCart(String id) async {
    return cartApi.removeFromCart(id);
  }
}

abstract interface class CartApi {
  Future<List<CartItem>> getCartList();
  Future<void> addToCart(CartItem cartItem);
  Future<void> removeFromCart(String id);
}

class LocalCartApi implements CartApi {
  @override
  Future<List<CartItem>> getCartList() async {
    return cartItems.map((cartMap) {
      return CartItem(
        cartId: cartMap['cartId'],
        count: int.parse(cartMap['count']),
        productId: cartMap['productId'],
        additives: cartMap['additives'],
        size: cartMap['size'],
      );
    }).toList();
  }

  @override
  Future<void> addToCart(CartItem cartItem) async {
    //TODO: add to cart
  }

  @override
  Future<void> removeFromCart(String id) async {
    //TODO: remove from cart
  }
}
