import 'package:p88_admin/core/response/error/abstract_failure.dart';

enum EnumGeneralFailureType {
  defaultMessage,
  customMessage
}

class GeneralFailure extends Failure{
  GeneralFailure({
    EnumGeneralFailureType type = EnumGeneralFailureType.defaultMessage,
    String message = 'internal server error'
  }): _type=type, _message=message;

  final EnumGeneralFailureType _type;
  final String _message;

  String toString() {
    return 'general failure message: ${errorMessage}';
  }
  
  @override
  String get errorMessage {
    return switch (_type) {
      EnumGeneralFailureType.defaultMessage => 'internal server error',
      EnumGeneralFailureType.customMessage => _message
    };
  }
}