import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/persentation/page/root_home/bloc/homepage_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_home/controller.dart';
import 'package:p88_admin/app/persentation/page/root_home/widget/lineachart_homepage/linechart_homepage.dart';
import 'package:p88_admin/app/persentation/resource/app_assets.dart';
import 'package:p88_admin/app/persentation/widget/button.dart';
import 'package:p88_admin/app/persentation/widget/error/error_try_again.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/error_snackbar.dart';
import 'package:p88_admin/app/persentation/widget/text_counter_animation.dart';
import 'package:p88_admin/app/util/color_item.dart';
import 'package:p88_admin/app/util/size.dart';
import 'package:p88_admin/app/util/state_listener_helper.dart';
import 'package:p88_admin/app/util/widget_helper.dart';
import 'package:p88_admin/core/di/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final controller = injector<HomeController>();
  @override
  void didChangeDependencies() {
    controller.didChangeDependencies(context);
    BlocProvider.of<HomeBloc>(context).add(InitiaHomeEvent());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // TODO will refactor soon
  int tenDaysSell = 10;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      StateListenerHelper().loading<LoadingHomeState>(state, context);
      // if (state is ErrorHomeState) {
      //   ShowErrorSnackbar().run(message: state.message);
      // }
    }, buildWhen: (previous, current) {
      if (current is SuccessHomeState ||
          current is ErrorHomeState ||
          current is LoadingHomeState) {
        return true;
      }

      return false;
    }, builder: (context, state) {
      if (state is ErrorHomeState) {
        return ErrorTryAgain(onPressed: () => controller.onTryAgain());
      }

      if (state is SuccessHomeState) {
        return RefreshIndicator(
          onRefresh: () async => controller.onTryAgain(),
          child: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorItem.tertiary,
                    ),
                    child: Column(
                      children: [
                        Gap.column(80.h),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h)
                                .copyWith(left: 20.w, right: 20.w),
                            decoration: BoxDecoration(
                              color: ColorItem.tertiary,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'for last 10 days you have sold ${tenDaysSell} Pcs',
                                  style: TextStyle(color: ColorItem.primary),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Stack(
                            children: [
                              BlocBuilder<HomeBloc, HomeState>(
                                buildWhen: (previous, current) {
                                  if (current is SuccessHomeState) {
                                    return true;
                                  }
                                  return false;
                                },
                                builder: (context, state) {
                                  return LineChartHomePage(
                                    duration: 1500,
                                  );
                                },
                              ),
                              Positioned(
                                  left: 10,
                                  top: 0,
                                  child: Text(
                                    'pcs',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorItem.primary),
                                  )),
                              Positioned(
                                right: 6,
                                bottom: 22,
                                child: Text(
                                  'days',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorItem.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap.column(40.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: UtilSize.PADDING_SCAFFOLD),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) {
                        if(current is SuccessHomeState) {
                          return true;
                        }

                        return false;
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                cardHomePage(title: 'Products', number: 24),
                                Gap.row(20.w),
                                cardHomePage(title: 'Products', number: 24),
                              ],
                            ),
                            Gap.column(20.w),
                            Row(
                              children: [
                                cardHomePage(title: 'Products', number: 24),
                                Gap.row(20.w),
                                cardHomePage(title: 'Products', number: 24),
                              ],
                            ),
                            // Gap.column(200.w),
                          ],
                        );
                      },
                    ),
                  ),

                  /// !TODO will delete sooon for test scroll only
                  Gap.column(100)
                ],
              ),
              Container(
                height: 70.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorItem.tertiary.withOpacity(0.4),
                        blurRadius: 1)
                  ],
                  color: ColorItem.secondary,
                  border: Border(
                      bottom: BorderSide(
                          color: ColorItem.tertiary.withOpacity(0.2))),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r)),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Muhammad Rizki',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              letterSpacing: 1.sp),
                        ),
                        Text('survervisor')
                      ],
                    ),
                    CircleAvatar()
                  ],
                ),
              ),
            ],
          ),
        );
      }

      return SizedBox();
    });
  }

  Widget cardHomePage({required int number, required String title}) {
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorItem.tertiary,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                    color: const Color.fromARGB(68, 0, 0, 0), width: 1.0)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: ColorItem.primary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: TextCounter(
                    count: 24,
                    duration: 1200,
                    style: TextStyle(
                        color: ColorItem.primary,
                        fontSize: 70.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
