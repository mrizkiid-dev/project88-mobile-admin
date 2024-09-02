import 'package:dio/dio.dart';
import 'package:network_inspector/network_inspector.dart';
import 'package:p88_admin/util/environment.dart';

class DioConfig {
  DioConfig({
    required this.dio
  });
  final Dio dio;

  factory DioConfig.configure() {
    final dio = Dio();
    dio.options.baseUrl = ENV.backendBaseUrl+'/api/';
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
    return DioConfig(dio: dio);
  }

  void interceptorsToken(String token) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer '+token;
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }
}