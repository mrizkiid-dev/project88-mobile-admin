import 'package:p88_admin/core/response/error/abstract_failure.dart';

enum EnumUnauthenticatedType {
  custom,
  defaultMessage
}

class UnauthenticatedException extends Failure {
  UnauthenticatedException({
    required EnumUnauthenticatedType type,
    String message = 'unAuntheticated',
    int statusCode = 500
  }): _message=message, _statusCode=statusCode, _type=type;

  final String _message;
  final int _statusCode;
  final EnumUnauthenticatedType _type;

  String toString() {
    return '{ message: ${errorMessage} , statusCode: ${_statusCode} }';
  }
  
  @override
  String get errorMessage {
    return switch (_type) {
      EnumUnauthenticatedType.defaultMessage => 'you need to login',
      EnumUnauthenticatedType.custom => _message
    };
  }
}