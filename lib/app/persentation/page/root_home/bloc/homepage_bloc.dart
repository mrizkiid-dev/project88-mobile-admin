import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:p88_admin/app/domain/usecase/user/get_user_usecase.dart';
import 'package:p88_admin/core/response/error/network_failure.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetUserUsecase getUserUseCase,
  }) : super(HomepageInitial()) {
    on<InitiaHomeEvent>((event, emit) async{
      try {
        emit(LoadingHomeState());
        // final response = await getUserUseCase.execute();
        await Future.delayed(Duration(seconds: 2));
        emit(SuccessHomeState());
        // throw 'a';
      } on NetworkFailure catch(e) {
        emit(ErrorHomeState(message: 'aduh amboyy'));
      } catch (e) {
        emit(ErrorHomeState(message: 'aduh amboyy'));
      }
    });
  }
}
