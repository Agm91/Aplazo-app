import 'package:aplazo_app/data/error/data_error.dart';
import 'package:aplazo_app/domain/error/domain_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toDomainError', () {
    test('should return genericError for DataError.notFound', () {
      final error = DataError.notFound('Not Found');
      final domainError = toDomainError(error);

      expect(domainError.message, 'Not Found');
    });

    test('should return genericError for DataError.badRequest', () {
      final error = DataError.badRequest('Bad Request');
      final domainError = toDomainError(error);

      expect(domainError.message, 'Bad Request');
    });

    test('should return genericError for DataError.serverError', () {
      final error = DataError.serverError('Server Error');
      final domainError = toDomainError(error);

      expect(domainError.message, 'Server Error');
    });

    test('should return genericError for DataError.exception', () {
      final error = DataError.exception(Exception('An exception'));
      final domainError = toDomainError(error);

      expect(domainError.message, 'Exception: An exception');
    });

    test('should return unknown for unknown DataError type', () {
      final error = DataError.unknown('Unknown error');
      final domainError = toDomainError(error);

      expect(domainError.message, 'Unknown error');
    });
  });
}
