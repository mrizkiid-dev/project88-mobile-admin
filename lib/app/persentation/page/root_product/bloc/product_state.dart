part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class InitialProductState extends ProductState {}

final class LoadingProductState extends ProductState {}

final class SuccessProductState extends ProductState {}

final class ErrorProductState extends ProductState {
  ErrorProductState({
    required this.message
  });

  final String message;

  @override
  List<Object> get props => [message];
}
