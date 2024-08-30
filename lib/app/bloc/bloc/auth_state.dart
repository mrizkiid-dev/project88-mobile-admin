part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}


final class AuthenticatedState extends AuthState {
  AuthenticatedState({
    required this.token
  });

  final String token;

  @override
  List<Object> get props => [token];
}

final class UnAuthenticatedState extends AuthState {}