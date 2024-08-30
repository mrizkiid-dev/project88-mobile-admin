import 'package:p88_admin/core/response/error/abstract_failure.dart';

class CacheFailure extends Failure{
  CacheFailure({
    required this.message
  });

  final String message;
}