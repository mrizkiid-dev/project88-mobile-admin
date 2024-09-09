import 'package:p88_admin/core/response/error/abstract_failure.dart';

enum EnumNetworkErrorType {
  unAuthenticated,
  unAuthorize,
  forbidden,
  defaultMessage,
  custom
}

class NetworkFailure extends Failure {
  NetworkFailure({
    required EnumNetworkErrorType type,
    String message='internal server error',
    int statusCode = 500
  }): _type=type, _message=message, _statusCode=statusCode;

  final String _message;
  final int? _statusCode;
  final EnumNetworkErrorType _type;

  String toString() {
    return '{ message: ${errorMessage} , statusCode: ${_statusCode} }';
  }
  
  @override
  String get errorMessage {
    return  switch (_type) {
      EnumNetworkErrorType.defaultMessage => 'internal server error',
      EnumNetworkErrorType.unAuthenticated => 'Email and Password are incorrect',
      EnumNetworkErrorType.forbidden => 'please use admin account',
      EnumNetworkErrorType.unAuthorize => 'you need to login',
      EnumNetworkErrorType.custom => _message
    };
  }
}