import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_chat/bloc/chat_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_chat/controller.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/error_snackbar.dart';
import 'package:p88_admin/app/util/state_listener_helper.dart';
import 'package:p88_admin/core/di/get_it.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = injector<ChatController>();

  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.didChangeDependencies(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          StateListenerHelper().loading<LoadingChatState>(state, context);
          if(state is ErrorChatState) {
            ShowErrorSnackbar().run(message: state.message);
          }
        },
        child: Center(
          child: Text('Chat'),
        ),
      ),
    );
  }
}
