part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppLoadingEvent extends AppEvent {}

final class AppSuccessEvent extends AppEvent {}

final class AppErrorEvent extends AppEvent {
  final String message;

  AppErrorEvent({required this.message});
}
