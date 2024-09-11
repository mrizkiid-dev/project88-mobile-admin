import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:p88_admin/app/persentation/page/root/bloc/root_bloc.dart';
import 'package:p88_admin/app/persentation/page/root/controller.dart';
import 'package:p88_admin/app/persentation/page/root_chat/index.dart';
import 'package:p88_admin/app/persentation/page/root_home/index.dart';
import 'package:p88_admin/app/persentation/page/root_order/index.dart';
import 'package:p88_admin/app/persentation/page/root_product/index.dart';
import 'package:p88_admin/app/persentation/page/profile/index.dart';
import 'package:p88_admin/app/persentation/widget/appbar.dart';
import 'package:p88_admin/app/persentation/widget/button/notificationButton.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/hide_snackbar.dart';
import 'package:p88_admin/core/di/get_it.dart';
import 'package:p88_admin/core/router/util.dart';
import 'package:p88_admin/app/util/color_item.dart';
import 'package:p88_admin/app/util/enums.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final controller = injector<RootController>();
  @override
  void didChangeDependencies() {
    controller.didChangeDependencies(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  EnumRootPage enumRootPage = EnumRootPage.homepage;

  @override
  Widget build(BuildContext context) {
    controller.resetExitTap();
    final rootPageBloc = BlocProvider.of<RootPageBloc>(context);
    return BackButtonListener(
      onBackButtonPressed: () async {
        return await controller.onBackButtonPressed(context);
      },
      child: BlocConsumer<RootPageBloc, RootPageState>(
        listener: (context, state) {
          HideSnackbar().run();
        },
        builder: (context, state) {
          controller.resetExitTap();
          return Scaffold(
            appBar: _appBar(state.enumRootPage),
            bottomNavigationBar:
                bottomNavbar(context, rootPagebloc: rootPageBloc),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: floatingActionButton(rootPageBloc),
            body: mainPage(state.enumRootPage),
          );
        },
      ),
    );
  }

  Widget mainPage(EnumRootPage value) {
    return switch (value) {
      EnumRootPage.homepage => HomePage(),
      EnumRootPage.product => ProductPage(),
      EnumRootPage.order => OrderPage(),
      EnumRootPage.chat => ChatPage(),
      EnumRootPage.profile => ProfilePage(),
    };
  }

  PreferredSizeWidget _appBar(EnumRootPage value) {
    return switch (value) {
      EnumRootPage.homepage => AppBarDefault(
          actions: [
            NotifcationButton(
              onPressed: () {
                context.push(Pages.NOTIFICATION_PATH);
              },
            ),
          ],
          isCenter: true,
        ),
      EnumRootPage.product => AppBarDefault(
          title: 'product',
          actions: [
            NotifcationButton(
              onPressed: () {
                context.push(Pages.NOTIFICATION_PATH);
              },
            ),
          ],
        ),
      EnumRootPage.order => AppBarDefault(
          title: 'order',
          actions: [
            NotifcationButton(
              onPressed: () {
                context.push(Pages.NOTIFICATION_PATH);
              },
            ),
          ],
        ),
      EnumRootPage.chat => AppBarDefault(
          title: 'chat',
          actions: [
            NotifcationButton(
              onPressed: () {
                context.push(Pages.NOTIFICATION_PATH);
              },
            ),
          ],
        ),
      EnumRootPage.profile => AppBarDefault(
          title: 'product',
          actions: [
            NotifcationButton(
              onPressed: () {
                context.push(Pages.NOTIFICATION_PATH);
              },
            ),
          ],
        ),
    };
  }

  Widget bottomNavbar(BuildContext context,
      {required RootPageBloc rootPagebloc}) {
    return BottomAppBar(
      height: 74,
      elevation: 20,
      notchMargin: 5,
      shadowColor: ColorItem.tertiary,
      child: Container(
        width: double.infinity,
        child: BlocBuilder<RootPageBloc, RootPageState>(
          bloc: rootPagebloc,
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                iconBottomAppBar(
                  onPressed: controller.onPressedHomeIcon,
                  icon: Icons.home_rounded,
                  title: 'home',
                  isActive: controller.checkIfHomePage(state),
                ),
                iconBottomAppBar(
                    onPressed: controller.onPressedProductIcon,
                    icon: Icons.amp_stories_rounded,
                    title: 'product',
                    isActive: controller.checkIfProductPage(state)),
                iconBottomAppBar(title: 'order'),
                iconBottomAppBar(
                    onPressed: controller.onPressedChatIcon,
                    icon: Icons.chat,
                    title: 'chat',
                    isActive: controller.checkIfChatPage(state)),
                iconBottomAppBar(
                    onPressed: () => controller.onPressedProfileIcon(context),
                    icon: Icons.account_circle,
                    title: 'profile'),
              ],
            );
          },
        ),
      ),
      shape: const CircularNotchedRectangle(),
      color: ColorItem.tertiary,
    );
  }

  Widget iconBottomAppBar(
      {void Function()? onPressed,
      IconData? icon,
      required String title,
      bool isActive = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (icon != null)
              Icon(icon,
                  color: isActive ? ColorItem.secondary : ColorItem.primary),
            Text(
              title,
              style: TextStyle(color: ColorItem.primary, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatingActionButton(RootPageBloc rootPageBloc) {
    return FloatingActionButton(
      onPressed: controller.onPressedOrderIcon,
      tooltip: 'Order',
      child: Icon(Icons.assignment),
      elevation: 2.0,
      shape:
          CircleBorder(side: BorderSide(color: ColorItem.tertiary, width: 1)),
      backgroundColor: ColorItem.secondary,
      foregroundColor: ColorItem.tertiary,
    );
  }
}
