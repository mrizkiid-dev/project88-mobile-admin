import 'package:p88_admin/core/response/error/abstract_failure.dart';

class UnauthenticatedException extends Failure {
  UnauthenticatedException({
    this.message = 'UnAuthorize',
    this.statusCode = 500
  });

  final String? message;
  final int? statusCode;

  String toString() {
    return '{ message: ${message} , statusCode: ${statusCode} }';
  }
}