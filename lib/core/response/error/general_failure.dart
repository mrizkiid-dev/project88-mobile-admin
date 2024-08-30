import 'package:p88_admin/core/response/error/abstract_failure.dart';

class GeneralFailure extends Failure{
  GeneralFailure({
    required this.message
  });

  final String message;
}