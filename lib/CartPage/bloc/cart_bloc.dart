import 'package:bloc/bloc.dart';
import 'package:food_order_app/ProductsBloc/products_bloc.dart';
import 'package:food_order_app/models/cart_item.dart';
import 'package:food_order_app/repositories/cart_repository.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.productsBloc}) : super(const CartState()) {
    on<FetchAndSetCart>(_onFetchAndSetCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  final ProductsBloc productsBloc;

  void _onFetchAndSetCart(
    FetchAndSetCart event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(
      cartStateLoad: CartStateLoad.loading,
    ));
    final cartItems = await CartRepository(cartApi: FirebaseCartApi()).loadCartItems(productsBloc);
    emit(state.copyWith(
      list: cartItems,
      cartStateLoad: CartStateLoad.loaded,
    ));
  }

  void _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(list: [...state.list, event.cartItem]));
  }

  void _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    await CartRepository(cartApi: FirebaseCartApi()).removeFromCart(event.cartId);
    final newList = List.of(state.list)
      ..removeWhere((cartItem) => cartItem.cartId == event.cartId);
    emit(state.copyWith(list: newList));
  }
}
