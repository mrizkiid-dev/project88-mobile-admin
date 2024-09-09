import 'package:p88_admin/core/response/error/abstract_failure.dart';

enum EnumCacheType {
  dataNotFound,
  internalError,
  customMessage,
}

class CacheFailure extends Failure{
  CacheFailure({
    EnumCacheType type = EnumCacheType.internalError,
    String message = 'internal server error'
  }): _type=type, _message=message;

  final EnumCacheType _type;
  final String _message;

  String toString() {
    return 'cache failure message: ${errorMessage}';
  }

  @override
  String get errorMessage {
    return switch (_type) {
      EnumCacheType.dataNotFound => 'data not found',
      EnumCacheType.internalError => 'internal server error',
      EnumCacheType.customMessage => _message
    };
  }
}