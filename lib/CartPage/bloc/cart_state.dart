part of 'cart_bloc.dart';

enum CartStateLoad { init, loading, loaded }

@immutable
class CartState {
  final List<CartItem> list;
  final CartStateLoad cartStateLoad;

  const CartState(
      {this.list = const [], this.cartStateLoad = CartStateLoad.init});

  CartState copyWith({List<CartItem>? list, CartStateLoad? cartStateLoad}) {
    return CartState(
      cartStateLoad: cartStateLoad ?? this.cartStateLoad,
      list: list ?? this.list,
    );
  }
}
