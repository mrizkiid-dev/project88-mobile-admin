part of 'line_chart_home_cubit.dart';

sealed class LineChartHomeState extends Equatable {
  const LineChartHomeState();

  @override
  List<Object> get props => [];
}

final class InitilLineChartHomeState extends LineChartHomeState {}

final class LoadingLineChartHomeState extends LineChartHomeState {}

final class SuccessLineChartHomeState extends LineChartHomeState {}
