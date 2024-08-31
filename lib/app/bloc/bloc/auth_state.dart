part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthLoadingState extends AuthState {}

final class AuthenticatedState extends AuthState {
  AuthenticatedState();


  @override
  List<Object> get props => [];
}

final class UnAuthenticatedState extends AuthState {}

final class ErrorAuthState extends AuthState {
  ErrorAuthState({
    required this.message
  });

  final String message;

  @override
  List<Object> get props => [message];
}