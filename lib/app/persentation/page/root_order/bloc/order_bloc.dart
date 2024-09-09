import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(InitialOrderState()) {
    on<InitialOrderEvent>((event, emit) async{
      try {
        emit(LoadingOrderState());
        await Future.delayed(Duration(seconds: 2));
        throw 'amboy';
        // emit(SuccessOrderState());
      } catch (e) {
        emit(ErrorOrderState(message: 'Order Bloc State'));
      }
    });
  }
}
