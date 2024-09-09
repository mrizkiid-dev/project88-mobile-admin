part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

final class InitialOrderState extends OrderState {}

final class LoadingOrderState extends OrderState {}

final class SuccessOrderState extends OrderState {}

final class ErrorOrderState extends OrderState {
  ErrorOrderState({
    required this.message
  });
  final String message;

  @override
  List<Object> get props => [message];
}
