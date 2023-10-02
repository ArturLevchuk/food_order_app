import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_preparation_event.dart';
part 'order_preparation_state.dart';

class OrderPreparationBloc
    extends Bloc<OrderPreparationEvent, OrderPreparationState> {
  OrderPreparationBloc(double price)
      : super(OrderPreparationState(price: price)) {
    on<UpdatePrice>(_onUpdatePrice);
    on<AddAdditive>(_onAddAdditive);
    on<RemoveAdditive>(_onRemoveAdditive);
  }

  void _onUpdatePrice(
    UpdatePrice event,
    Emitter<OrderPreparationState> emit,
  ) async {
    emit(
      state.copyWith(price: event.price),
    );
  }

  void _onAddAdditive(
    AddAdditive event,
    Emitter<OrderPreparationState> emit,
  ) async {
    emit(
      state.copyWith(additives: [...state.additives, event.additive]),
    );
  }

  void _onRemoveAdditive(
    RemoveAdditive event,
    Emitter<OrderPreparationState> emit,
  ) async {
    emit(
      state.copyWith(
        additives: List.of(state.additives)
          ..removeWhere(
              (element) => element.keys.contains(event.additive.keys.first)),
      ),
    );
  }
}
