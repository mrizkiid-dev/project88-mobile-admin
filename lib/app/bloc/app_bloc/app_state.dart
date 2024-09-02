part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();
  
  @override
  List<Object> get props => [];
}

final class AppBlocInitial extends AppState {}

final class AppLoadingState extends AppState {}

final class AppSuccessState extends AppState {}

final class AppErrorState extends AppState{
  final String message;

  AppErrorState({required this.message});
}