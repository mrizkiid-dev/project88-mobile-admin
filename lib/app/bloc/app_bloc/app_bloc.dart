import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppBlocInitial()) {
    on<AppLoadingEvent>((event, emit) {
      emit(AppLoadingState());
    });

    on<AppSuccessEvent>((event, emit) {
      emit(AppSuccessState());
    });

    on<AppErrorEvent>((event, emit) {
      emit(AppErrorState(message: event.message));
    });
  }
}
