import 'package:meta/meta.dart';

@immutable
class OrderPreparationState {
  final Map<String, dynamic> size;
  final Map<String, dynamic> additives;
  final int count;

  const OrderPreparationState({
    this.count = 1,
    this.size = const {},
    this.additives = const {},
  });

  double get getPrice {
    // if (size.keys.isEmpty) {
    //   return 0;
    // }
    double price = 0;
    price += size.values.firstOrNull ?? 0;
    additives.forEach((key, value) {
      price += value;
    });
    return price * count;
  }

  OrderPreparationState copyWith(
      {int? count,
      Map<String, dynamic>? size,
      Map<String, dynamic>? additives}) {
    return OrderPreparationState(
      count: count ?? this.count,
      size: size ?? this.size,
      additives: additives ?? this.additives,
    );
  }
}
