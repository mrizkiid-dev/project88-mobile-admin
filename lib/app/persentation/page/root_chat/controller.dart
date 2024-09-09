import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_chat/bloc/chat_bloc.dart';
import 'package:p88_admin/core/controller.dart';

class ChatController extends Controller {

  ChatBloc? _chatBloc;

  @override
  void didChangeDependencies(BuildContext context) {
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc?.add(ChatInitialEvent());
  }

  @override
  void dispose() {
    _chatBloc = null;
  }

  @override
  void initState() {
    
  }
  
}