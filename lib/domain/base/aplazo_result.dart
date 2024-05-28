class AplazoResult<ErrorType, ResultType> {
  const AplazoResult();

  T fold<T>({
    required T Function(ErrorType error) onError,
    required T Function(ResultType result) onSuccess,
  }) {
    if (this is Error<ErrorType, ResultType>) {
      return onError((this as Error<ErrorType, ResultType>).error);
    } else if (this is Success<ErrorType, ResultType>) {
      return onSuccess((this as Success<ErrorType, ResultType>).value);
    } else {
      throw Exception('Unrecognized subclass');
    }
  }
}

class Success<ErrorType, ResultType> extends AplazoResult<ErrorType, ResultType> {
  final ResultType value;

  Success(this.value);
}

class Error<ErrorType, ResultType> extends AplazoResult<ErrorType, ResultType> {
  final ErrorType error;

  Error(this.error);
}
