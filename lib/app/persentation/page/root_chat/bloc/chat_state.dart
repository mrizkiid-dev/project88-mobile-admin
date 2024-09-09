part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class InitialChatState extends ChatState {}

final class LoadingChatState extends ChatState {}

final class SuccessChatState extends ChatState {}

final class ErrorChatState extends ChatState {
  ErrorChatState({
    required this.message
  });
  final String message;

  @override
  List<Object> get props => [message];
}


