import 'package:p88_admin/core/response/error/abstract_failure.dart';

class UnauthenticatedError extends Failure {
  UnauthenticatedError({
    required this.message,
    this.statusCode = 500
  });

  final String message;
  final int? statusCode;

  String toString() {
    return '{ message: ${message} , statusCode: ${statusCode} }';
  }
}