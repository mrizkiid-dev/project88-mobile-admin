import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(InitialChatState()) {
    on<ChatEvent>((event, emit) async {
        try {
          emit(LoadingChatState());
          await Future.delayed(Duration(seconds: 2));
          throw 'error';
          // emit(SuccessChatState());
        } catch (e) {
          emit(ErrorChatState(message: 'Chat Bloc'));
        }
    });
  }
}
