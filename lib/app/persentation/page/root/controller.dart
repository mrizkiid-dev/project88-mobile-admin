import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:p88_admin/app/persentation/page/root/bloc/root_bloc.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/exit_snackbar.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/hide_snackbar.dart';
import 'package:p88_admin/app/util/enums.dart';
import 'package:p88_admin/app/util/extension.dart';
import 'package:p88_admin/core/controller.dart';
import 'package:p88_admin/core/router/util.dart';

class RootController extends Controller {

  int exitTap = 0;
  RootPageBloc? _rootPageBloc;

  @override
  void didChangeDependencies(BuildContext context) {
    _rootPageBloc = BlocProvider.of<RootPageBloc>(context);
  }

  @override
  void dispose() {
    resetExitTap();
    HideSnackbar().run();
    _rootPageBloc = null;
  }

  @override
  void initState() {
    
  }

  Future<bool> onBackButtonPressed(BuildContext context) async{
    final location = GoRouter.of(context).location;
      if(location == Pages.ROOT_PATH) {
        if(exitTap > 0) {
          // exitTap = 0;
          return false;
        } else {
          exitTap+=1;
          ExitSnackbar().run();
          return true;
        }
      }

      return false;
  }

  void resetExitTap() {
    exitTap = 0;
  }

  void onPressedHomeIcon() {
    _rootPageBloc?.add(RootHomePageEvent());
  }
  bool checkIfHomePage(RootPageState state) {
    return state.enumRootPage == EnumRootPage.homepage;
  }

  void onPressedProductIcon() {
    _rootPageBloc?.add(RootProductPageEvent());
  }
  bool checkIfProductPage(RootPageState state) {
    return (state.enumRootPage == EnumRootPage.product);
  }

  void onPressedChatIcon() {
    _rootPageBloc?.add(RootChatPageEvent());
  }
  bool checkIfChatPage(RootPageState state) {
    return (state.enumRootPage == EnumRootPage.chat);
  }

  void onPressedProfileIcon(BuildContext context) {
    context.push(Pages.PROFIL_PATH);
  }

  void onPressedOrderIcon() {
    _rootPageBloc?.add(RootOrderPageEvent());
  }

  
}