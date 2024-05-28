import 'package:aplazo_app/data/error/data_error.dart';

class DomainError {
  final String? message;

  const DomainError._(this.message);

  factory DomainError.invalidParams() => DomainError._('Invalid parameters');
  factory DomainError.genericError(String? message) =>
      DomainError._(message ?? 'Something happened');
  factory DomainError.unknown(String? message) => DomainError._(message);
}

DomainError toDomainError(DataError error) {
  switch (error.runtimeType) {
    case DataError.notFound:
    case DataError.badRequest:
    case DataError.serverError:
    case DataError.exception:
      return DomainError.genericError(error.message);
    default:
      return DomainError.unknown(error.message);
  }
}
