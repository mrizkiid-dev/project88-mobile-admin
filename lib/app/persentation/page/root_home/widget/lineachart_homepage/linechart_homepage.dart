import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/persentation/page/root_home/widget/lineachart_homepage/cubit/line_chart_home_cubit.dart';
import 'package:p88_admin/app/util/color_item.dart';

class LineChartHomePage extends StatefulWidget {
  const LineChartHomePage({
    super.key,
    this.duration = 2000,
  });

  final int duration;

  @override
  State<LineChartHomePage> createState() => _LineChartHomePageState();
}

class _LineChartHomePageState extends State<LineChartHomePage> {
  @override
  void initState() {
    _lineChartHomeCubit = LineChartHomeCubit();
    _lineChartHomeCubit?.onInitial(widget.duration);
    super.initState();
  }

  LineChartHomeCubit? _lineChartHomeCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h).copyWith(left: 1.w ,right: 16.w),
      child: AspectRatio(
        aspectRatio: 2,
        child: BlocBuilder<LineChartHomeCubit, LineChartHomeState>(
          bloc: _lineChartHomeCubit,
          builder: (context, state) {
            bool isShowMainData = false;
            if (state is SuccessLineChartHomeState) {
              isShowMainData = true;
            }

            if (state is LoadingLineChartHomeState) {
              isShowMainData = false;
            }
            return LineChart(
              duration: Duration(milliseconds: 700),
              curve: Curves.easeIn,
              isShowMainData ? _lineChartData(mainData) : _lineChartData(initialData)
            );
          },
        ),
      ),
    );
  }

  LineChartData _lineChartData(List<FlSpot> spots) {
    return 
    LineChartData(
      maxY: 13,
      maxX: 11,
      backgroundColor: ColorItem.secondary,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 1,
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
            show: true,
            spots: spots,
            color: Color.fromARGB(214, 80, 79, 79),
            barWidth: 2,
            preventCurveOverShooting: true,
            isStrokeCapRound: true,
            isCurved: true,
            belowBarData: BarAreaData(
                show: true, color: Color.fromARGB(239, 80, 79, 79)),
            dotData: FlDotData(show: false),
          ),
      ],
      titlesData: FlTitlesData(
        topTitles:
            AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: leftTitleWidgets,
          // reservedSize: 12,
          interval: 1,
        )),
        bottomTitles: AxisTitles(
          axisNameSize: 10,
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets),
        ),
      ),
      lineTouchData: LineTouchData(enabled: false),

    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
      color: ColorItem.primary
    );
    String text = value.truncate().toString();;

    // if (((value % 2) == 0) && value > 0) {
    //   text = value.truncate().toString();
    // }

    if(value > 10) {
      text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
      color: ColorItem.primary
    );

    String text = '';

    if (((value % 2) == 0) && value > 0) {
      text = value.truncate().toString();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  List<FlSpot> mainData = [
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
    FlSpot(11, 0),
  ];

  List<FlSpot> initialData = [
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),
    FlSpot(4, 0),
    FlSpot(5, 0),
    FlSpot(6, 0),
    FlSpot(7, 0),
    FlSpot(8, 0),
    FlSpot(9, 0),
    FlSpot(10, 0),
    FlSpot(11, 0),
  ];
}