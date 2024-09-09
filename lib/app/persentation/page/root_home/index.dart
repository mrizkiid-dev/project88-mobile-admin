import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/persentation/page/root_home/bloc/homepage_bloc.dart';
import 'package:p88_admin/app/persentation/page/root_home/controller.dart';
import 'package:p88_admin/app/persentation/widget/snackbar/error_snackbar.dart';
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
    BlocProvider.of<HomeBloc>(context).add(HomeInitial());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    debugPrint('homepage disponse');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        StateListenerHelper().loading<LoadingHomeState>(state, context);
        if(state is ErrorHomeState) {
          ShowErrorSnackbar().run(message: state.message);
        }
      },
      child:  Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(top: 80.h),
                child: Stack(
                  children: [
                    LineChartHomePage(),
                    Positioned(
                      left: 0,
                      child: Text('pcs', style: TextStyle(fontWeight: FontWeight.bold),)),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Text('days', style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: UtilSize.PADDING_SCAFFOLD),
                child: Column(
                  children: [
                    Row(children: [
                      cardHomePage(title: 'Products', number: 24),
                      Gap.row(20.w),
                      cardHomePage(title: 'Products', number: 24),
                    ],),
                    Gap.column(20.w),
                    Row(children: [
                      cardHomePage(title: 'Products', number: 24),
                      Gap.row(20.w),
                      cardHomePage(title: 'Products', number: 24),
                    ],),
                    // Gap.column(200.w),
                  ],
                ),
              ),
              
              /// !TODO will delete sooon for test scroll only
              Gap.column(100)
              // LineChartSample2()
            ],
          ),
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorItem.tertiary.withOpacity(0.4),
                  blurRadius: 1
                )
              ],
              color: ColorItem.secondary,
              border: Border(bottom: BorderSide(color: ColorItem.tertiary.withOpacity(0.2))),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r), bottomRight: Radius.circular(25.r)),
              
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Muhammad Rizki', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, letterSpacing: 1.sp),),
                    Text('survervisor')
                  ],
                ),
                CircleAvatar()
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget cardHomePage({required int number, required String title}) {
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: AspectRatio(
          aspectRatio: 1/1,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorItem.tertiary,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: const Color.fromARGB(68, 0, 0, 0),
                width: 1.0
              )
            ),
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
                  child: Text(
                    number.toString(), 
                    style: TextStyle(
                      color: ColorItem.primary,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
      );
  }
}

class LineChartHomePage extends StatefulWidget {
  const LineChartHomePage({super.key});

  @override
  State<LineChartHomePage> createState() => _LineChartHomePageState();
}

class _LineChartHomePageState extends State<LineChartHomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10).copyWith(top: 20, bottom: 20),
      child: AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          LineChartData(
            backgroundColor: ColorItem.secondary,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 2,
              verticalInterval: 1,
              
            ),
            lineBarsData: [
              LineChartBarData(
                show: true,
                spots: [
                  FlSpot(0, 0),
                  FlSpot(1, 5),
                  FlSpot(2, 2),
                  FlSpot(3, 10),
                  FlSpot(4, 2),
                  FlSpot(5, 3),
                  FlSpot(6, 1),
                  FlSpot(7, 0),
                  FlSpot(8, 0),
                  FlSpot(9, 5),
                  FlSpot(10, 2),
                ],
                color: Color.fromARGB(214, 80, 79, 79),
                barWidth: 2,
                preventCurveOverShooting: true,
                isStrokeCapRound: true,
                isCurved: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: Color.fromARGB(239, 80, 79, 79)
                ),
                dotData: FlDotData(show: false)
              ),
            ],
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 42,
                  interval: 1,
                )),
              bottomTitles: AxisTitles(
                axisNameSize: 10,
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets
                )
              )
            )
          )
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text = '';

    if (((value % 2) == 0) && value > 0) {
      text = value.truncate().toString();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );

    String text = '';

    if (((value % 2) == 0) && value > 0) {
      text = value.truncate().toString();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

}
