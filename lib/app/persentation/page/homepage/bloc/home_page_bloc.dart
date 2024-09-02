import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/domain/usecase/user/get_user_usecase.dart';
import 'package:p88_admin/core/response/error/unauthenticated.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({
    required AuthBloc authBloc,
    required GetUserUsecase getUserUsecase,
  }) : super(HomePageInitial()) {
    on<HomeTestFetch>((event, emit) async{
      try {
        emit(HomePageLoadingState());
        final user = await getUserUsecase.execute();
        debugPrint('user = '+user.toString());
        emit(HomePageFetchSuccess());
      } on UnauthenticatedException {
        authBloc.add(UnAuthenticatedEvent());
      } catch (e) {
        debugPrint('error HomeTestFetch = '+ e.toString());
        emit(HomePageErrorState(message: 'gagal fetch'));
      }
    });
  }
}
