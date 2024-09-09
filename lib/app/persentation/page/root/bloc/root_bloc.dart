import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/domain/usecase/user/get_user_usecase.dart';
import 'package:p88_admin/app/util/enums.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootPageBloc extends Bloc<RootPageEvent, RootPageState> {
  RootPageBloc({
    required AuthBloc authBloc,
    required GetUserUsecase getUserUsecase,
  }) : super(RootPageState.initial()) {
    // on<HomeTestFetch>((event, emit) async{
      // try {
      //   emit(HomePageLoadingState());
      //   final user = await getUserUsecase.execute();
      //   debugPrint('user = '+user.toString());
      //   emit(HomePageFetchSuccess());
      // } on UnauthenticatedException {
      //   authBloc.add(UnAuthenticatedEvent());
      // } catch (e) {
      //   debugPrint('error HomeTestFetch = '+ e.toString());
      //   emit(HomePageErrorState(message: 'gagal fetch'));
      // }
    // });

    on<RootHomePageEvent>((event, emit) async{
      debugPrint('RootHomePageEvent');
      emit(RootPageState.homepage());
    });

    on<RootProductPageEvent>((event, emit) async{
      debugPrint('RootProductPageEvent');
      emit(RootPageState.productpage());
    });

    on<RootOrderPageEvent>((event, emit) async{
      debugPrint('RootOrderPageEvent');
      emit(RootPageState.orderpage());
    });

    on<RootChatPageEvent>((event, emit) async{
      debugPrint('RootChatPageEvent');
      emit(RootPageState.chatPage());
    });

    on<RootProfilePageEvent>((event, emit) async{
      debugPrint('RootProfilePageEvent');
      emit(RootPageState.profilepage());
    });
  }
}
