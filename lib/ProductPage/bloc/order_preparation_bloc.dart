import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_preparation_event.dart';
part 'order_preparation_state.dart';

class OrderPreparationBloc
    extends Bloc<OrderPreparationEvent, OrderPreparationState> {
  OrderPreparationBloc(Map<String, dynamic> size, int count)
      : super(OrderPreparationState(size: size, count: count)) {
    on<UpdatePrice>(_onUpdatePrice);
    on<AddAdditive>(_onAddAdditive);
    on<RemoveAdditive>(_onRemoveAdditive);
  }

  void _onUpdatePrice(
    UpdatePrice event,
    Emitter<OrderPreparationState> emit,
  ) async {
    emit(
      state.copyWith(size: event.size),
    );
  }

  void _onAddAdditive(
    AddAdditive event,
    Emitter<OrderPreparationState> emit,
  ) async {
    final Map<String, dynamic> newAdditives = Map.of(state.additives);
    newAdditives.addAll(event.additive);
    emit(
      state.copyWith(additives: newAdditives),
    );
  }

  void _onRemoveAdditive(
    RemoveAdditive event,
    Emitter<OrderPreparationState> emit,
  ) async {
    final Map<String, dynamic> newAdditives = Map.of(state.additives);
    newAdditives.removeWhere((key, value) => key == event.additive.keys.first);
    emit(
      state.copyWith(
        additives: newAdditives,
      ),
    );
  }
}
