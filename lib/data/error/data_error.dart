class DataError {
  final String message;

  const DataError._(this.message);

  factory DataError.notFound(String? message) => DataError._(message ?? 'Npt Found');
  factory DataError.badRequest(String? message) => DataError._(message ?? 'Bad Request');
  factory DataError.serverError(String? message) => DataError._(message ?? 'Server Error');
  factory DataError.exception(Exception exception) => DataError._('${exception.toString()}');
  factory DataError.unknown(String message) => DataError._('$message');
}
