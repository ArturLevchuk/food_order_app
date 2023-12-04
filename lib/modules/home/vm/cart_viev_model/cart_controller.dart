import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_order_app/repositories/cart_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../models/cart_item.dart';
part 'cart_state.dart';

class CartController implements Disposable {
  final CartApi cartApi;
  CartController({required this.cartApi});

  final BehaviorSubject<CartState> _streamController =
      BehaviorSubject.seeded(const CartState());
  Stream<CartState> get stream => _streamController.stream;
  CartState get state => _streamController.value;

  Future<void> fetchAndSetCart() async {
    _streamController.add(
      state.copyWith(cartStateLoad: CartStateLoad.loading),
    );
    final List<CartItem> cartItems = await cartApi.getCartList();
    _streamController.add(
      state.copyWith(list: cartItems, cartStateLoad: CartStateLoad.loaded),
    );
  }

  Future<void> addToCart(CartItem cartItem) async {
    await cartApi.addToCart(cartItem);
    _streamController.add(state.copyWith(list: [...state.list, cartItem]));
  }

  Future<void> removeFromCart(String cartId) async {
    await cartApi.removeFromCart(cartId);
    _streamController.add(state.copyWith(
        list: List.of(state.list)
          ..removeWhere((element) => element.cartId == cartId)));
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
