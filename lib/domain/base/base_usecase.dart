abstract class BaseUseCase<Result, Params> {
  Future<Result> call(Params? params);
}
