import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'line_chart_home_state.dart';

class LineChartHomeCubit extends Cubit<LineChartHomeState> {
  LineChartHomeCubit() : super(InitilLineChartHomeState());

  void onInitial(int duration) async {
    emit(LoadingLineChartHomeState());
    await Future.delayed(Duration(milliseconds: duration));
    emit(SuccessLineChartHomeState());
  }
}
