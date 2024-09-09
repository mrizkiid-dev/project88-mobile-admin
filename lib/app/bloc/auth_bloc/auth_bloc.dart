import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:p88_admin/app/domain/usecase/auth/check_authenticate.dart';
import 'package:p88_admin/app/domain/usecase/auth/login_usecase.dart';
import 'package:p88_admin/app/domain/usecase/auth/logout_usecase.dart';
import 'package:p88_admin/core/response/error/cache_failure.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';
import 'package:p88_admin/core/response/error/unauthenticated.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUsecase loginUsecase,
    required CheckAuthenticateUseCase checkAuthenticateUseCase,
    required LogoutUsecase logoutUsecase
  }) : super(UnAuthenticatedState()) {
    on<AuthLoginEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        String email = event.email;
        String password = event.password;
        debugPrint('AuthBloc = '+email+' == '+password);
      
        final result = await loginUsecase.execute(ParamLoginUsecase(email: email, password: password));
        emit(AuthenticatedState());
      } on UnauthenticatedException catch(e) {
        emit(ErrorAuthState(message: e.errorMessage));
      } on CacheFailure catch(e) {
        emit(ErrorAuthState(message: e.toString()));
      } on NetworkFailure catch(e) {
        emit(ErrorAuthState(message: e.errorMessage));
      } catch (e) {
        debugPrint('Auth Bloc failed = ' + e.toString());
        emit(ErrorAuthState(message: 'internal Server error'));
      }
    });

    on<AuthenticatedCheckEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        final isAuthenticated = await checkAuthenticateUseCase.execute();
        if (isAuthenticated) {
          emit(AuthenticatedState());
        } else {
          throw FormatException('token not found');
        }
      } catch (e) {
        emit(UnAuthenticatedState());
      }
    });

    on<AuthLogoutEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        final response = await logoutUsecase.execute();
        if(!response) {
          throw FormatException('logout failed');
        }
        emit(UnAuthenticatedState());
      } on UnauthenticatedException {
        emit(UnAuthenticatedState());
      } catch (e) {
        emit(ErrorAuthState(message: 'logout fail'));
      }
    });

    on<UnAuthenticatedEvent>((event, emit) async {
      emit(UnAuthenticatedState());
    });
  }
}
