part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent{
  AuthLoginEvent({
    required this.email,
    required this.password
  });

  final String email;
  final String password;
}

class AuthLogoutEvent extends AuthEvent{}

class AuthenticatedCheckEvent extends AuthEvent{}
