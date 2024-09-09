import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:p88_admin/core/response/error/unauthenticated.dart';

class UtilException {
  static Exception checkUnAuthenticateException({
    String? trace, 
    required DioException dioException
  }) {
    if(trace != null) {
      debugPrint(trace+' - '+(dioException.message ?? 'UnAuthenticate'));
    }
    final statusCode = dioException.response?.statusCode;
    if(statusCode != null && (statusCode != 401 || statusCode != 403)) {
      return UnauthenticatedException(type: EnumUnauthenticatedType.defaultMessage);
    } 
    return dioException;
  }
}