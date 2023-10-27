part of 'order_preparation_bloc.dart';

@immutable
class OrderPreparationState {
  final Map<String, dynamic> size;
  final Map<String, dynamic> additives;
  final int count;

  const OrderPreparationState({
    required this.count,
    required this.size,
    this.additives = const {},
  });

  double get getPrice {
    double price = 0;
    price += size.values.first;
    additives.forEach((key, value) {
      price += value;
    });
    return price * count;
  }

  OrderPreparationState copyWith(
      {int? count,  Map<String, dynamic>? size, Map<String, dynamic>? additives}) {
    return OrderPreparationState(
      count: count ?? this.count ,
      size: size ?? this.size,
      additives: additives ?? this.additives,
    );
  }
}
