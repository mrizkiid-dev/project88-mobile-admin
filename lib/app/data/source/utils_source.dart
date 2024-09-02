import 'package:p88_admin/app/data/source/local/auth_cache.dart';
import 'package:p88_admin/core/data/network/dio.dart';

class UtilSource {
  static Future<void> setTokenOnDio(DioConfig dioConfig, AuthCache authCache) async{
    final token = await authCache.getToken();
    if (token != null) {
      dioConfig.interceptorsToken(token);
    }
  }
}