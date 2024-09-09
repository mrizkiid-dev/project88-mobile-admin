part of 'root_bloc.dart';

sealed class RootPageEvent extends Equatable {
  const RootPageEvent();

  @override
  List<Object> get props => [];
}

final class RootHomePageEvent extends RootPageEvent {}
final class RootChatPageEvent extends RootPageEvent {}
final class RootOrderPageEvent extends RootPageEvent {}
final class RootProductPageEvent extends RootPageEvent {}
final class RootProfilePageEvent extends RootPageEvent {}
