import 'package:dio/dio.dart';
import 'package:p88_admin/core/response/error/abstract_failure.dart';

class NetworkFailure extends Failure {
  NetworkFailure({
    required this.message,
    this.statusCode = 500
  });

  final String message;
  final int? statusCode;

  String toString() {
    return '{ message: ${message} , statusCode: ${statusCode} }';
  }
}