import 'package:dio/dio.dart';
import 'package:network_inspector/common/utils/dio_interceptor.dart';
import 'package:network_inspector/network_inspector.dart';

class DioConfig {
  final dio = Dio();
  final networkInspector = NetworkInspector();

  void configureDio() {
    // Set default configs
    dio.options.baseUrl = 'https://74d1-202-93-229-42.ngrok-free.app/api';
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);
    dio.options.responseType = ResponseType.json;

    // dio.interceptors.add(
    //   DioInterceptor(
    //     logIsAllowed: true,
    //     networkInspector: networkInspector,
    //     onHttpFinish: (hashCode, title, message) {
    //       notifyActivity(
    //         title: title,
    //         message: message,
    //       );
    //     },
    //   )
    // );
  }
}