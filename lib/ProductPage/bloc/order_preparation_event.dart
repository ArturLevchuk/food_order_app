part of 'order_preparation_bloc.dart';

@immutable
sealed class OrderPreparationEvent {}

class UpdatePrice extends OrderPreparationEvent {
  final double price;

  UpdatePrice({required this.price});
}

class AddAdditive extends OrderPreparationEvent {
  final Map<String, dynamic> additive;

  AddAdditive({required this.additive});
}

class RemoveAdditive extends OrderPreparationEvent {
  final Map<String, dynamic> additive;

  RemoveAdditive({required this.additive});
}
