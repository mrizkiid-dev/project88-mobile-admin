import 'package:dartz/dartz.dart';
import 'package:p88_admin/core/response/error/abstract_failure.dart';

abstract class UseCases {}

abstract class UseCase<Params, Result> extends UseCases {
  Result execute(Params params);
}

abstract class UseCaseWithoutParams<Result> extends UseCases {
  Result execute();
}

abstract class UseCaseFetchWithoutParams<Result> extends UseCases {
  Future<Either<Failure, Result>> execute();
}

abstract class UseCaseFetch<Params, Result> extends UseCases {
  Future<Either<Failure, Result>> execute(Params params);
}
