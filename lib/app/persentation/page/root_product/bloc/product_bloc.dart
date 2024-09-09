import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitialProductState()) {
    on<InitialProductEvent>((event, emit) async {
      try {
        emit(LoadingProductState());
        await Future.delayed(Duration(seconds: 2));
        throw 'amboy error';
        // emit(SuccessOrderState());
      } catch (e) {
        debugPrint('aw aw aw');
        emit(ErrorProductState(message: 'amboy masalahnya disini'));
      }
    });
  }
}
