part of 'homepage_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomepageInitial extends HomeState {}

final class LoadingHomeState extends HomeState {}

final class SuccessHomeState extends HomeState {
  const SuccessHomeState({
    this.isShowMainData = false,
  });

  final bool isShowMainData;

  @override
  List<Object> get props => [isShowMainData];
}

final class ErrorHomeState extends HomeState {
  ErrorHomeState({
    required this.message
  });

  final String message;

  @override
  List<Object> get props => [message];
}
