part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();
  
  @override
  List<Object> get props => [];
}

final class HomePageInitial extends HomePageState {}

final class HomePageLoadingState extends HomePageState {}

final class HomePageFetchSuccess extends HomePageState {}

final class HomePageErrorState extends HomePageState {
  HomePageErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
