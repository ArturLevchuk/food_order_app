part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class FetchAndSetCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem cartItem;

  AddToCart({required this.cartItem});
}

class RemoveFromCart extends CartEvent {
  final String cartId;

  RemoveFromCart({required this.cartId});
}
