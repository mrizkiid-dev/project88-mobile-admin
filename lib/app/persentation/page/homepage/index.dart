import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p88_admin/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:p88_admin/app/persentation/page/homepage/bloc/home_page_bloc.dart';
import 'package:p88_admin/app/persentation/widget/auth/auth_container.dart';
import 'package:p88_admin/app/persentation/widget/snackbar.dart';
import 'package:p88_admin/util/color_item.dart';
import 'package:p88_admin/util/state_listener_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    final homePageBloc = BlocProvider.of<HomePageBloc>(context);
    homePageBloc.add(HomeTestFetch());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return AuthContainer(
      widget: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if(state is HomePageErrorState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBarError().run(state.message));
            }
          StateListenerHelper().loading<HomePageLoadingState>(state, context);
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: ColorItem.primary),
            child: Center(
              child: ElevatedButton(
                  onPressed: () => {authBloc.add(AuthLogoutEvent())},
                  child: Text('logout')),
            ),
          );
        },
      ),
    );
  }
}
