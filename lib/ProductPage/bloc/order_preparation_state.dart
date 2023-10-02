part of 'order_preparation_bloc.dart';

@immutable
class OrderPreparationState {
  final double price;
  final List<Map<String, dynamic>> additives;

  const OrderPreparationState({required this.price, this.additives = const []});

  double get getPrice {
    double additiveSum = 0;
    for (var additive in additives) {
      additiveSum += additive.values.first;
    }
    return price + additiveSum;
  }

  OrderPreparationState copyWith(
      {double? price, List<Map<String, dynamic>>? additives}) {
    return OrderPreparationState(
      price: price ?? this.price,
      additives: additives ?? this.additives,
    );
  }
}
