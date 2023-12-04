import 'package:rxdart/rxdart.dart';

import 'order_preparation_state.dart';

class OrderPreparationController {
  OrderPreparationController() {
    _controller = BehaviorSubject.seeded(
      const OrderPreparationState(),
    );
  }

  late final BehaviorSubject<OrderPreparationState> _controller;

  Stream<OrderPreparationState> get stream => _controller.stream;
  OrderPreparationState get state => _controller.value;


  void init({required int count, required Map<String, dynamic> size}) {
    if (state.size.keys.isEmpty) {
      _controller.add(
        state.copyWith(
          count: count,
          size: size,
        ),
      );
    }
  }

  void updateSize({required Map<String, dynamic> size}) {
    _controller.add(
      state.copyWith(
        size: size,
      ),
    );
  }

  void addAdditive({required Map<String, dynamic> additive}) {
    _controller.add(
        state.copyWith(additives: Map.of(state.additives)..addAll(additive)));
  }

  void removeAdditive({required Map<String, dynamic> additive}) {
    _controller.add(state.copyWith(
        additives: Map.of(state.additives)..remove(additive.keys.first)));
  }
}
