part of 'homepage_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class InitiaHomeEvent extends HomeEvent {
  const InitiaHomeEvent();
}
