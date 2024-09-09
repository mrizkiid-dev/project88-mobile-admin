
abstract class UseCases {}

abstract class UseCase<Params, Result> extends UseCases {
  Result execute(Params params);
}

abstract class UseCaseWithoutParams<Result> extends UseCases {
  Result execute();
}

abstract class UseCaseFetchWithoutParams<Result> extends UseCases {
  Future<Result> execute();
}

abstract class UseCaseFetch<Params, Result> extends UseCases {
  Future<Result> execute(Params params);
}
