import 'package:dio/dio.dart';
import 'package:network_inspector/common/utils/dio_interceptor.dart';
import 'package:network_inspector/network_inspector.dart';
import 'package:p88_admin/util/environment.dart';

class DioConfig {
  final dio = Dio();
  final networkInspector = NetworkInspector();

  void configureDio() {
    // Set default configs
    dio.options.baseUrl = ENV.backendBaseUrl+'/api/';
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);
    dio.options.responseType = ResponseType.json;
  }

  void interceptorsToken(String token) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer '+token;
          return handler.next(options);
        },
      ),
    );
  }
}