import 'package:aplazo_app/data/error/data_error.dart';
import 'package:aplazo_app/domain/usecase/register_customer_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aplazo_app/domain/base/aplazo_result.dart';
import 'package:aplazo_app/domain/error/domain_error.dart';
import 'package:aplazo_app/domain/models/customer.dart';
import 'package:aplazo_app/domain/models/response/register_customer_response.dart';
import 'package:aplazo_app/domain/repositories/register_customer_repository.dart';

class MockRegisterCustomerRepository implements RegisterCustomerRepository {
  Future<AplazoResult<DataError, RegisterCustomerResponse>> Function(
      Customer customer)? registerCustomerCallback;

  @override
  Future<AplazoResult<DataError, RegisterCustomerResponse>> registerCustomer(
      Customer customer) {
    if (registerCustomerCallback != null) {
      return registerCustomerCallback!(customer);
    } else {
      throw UnimplementedError();
    }
  }
}

void main() {
  group('RegisterCustomerUsecase', () {
    late RegisterCustomerUsecase usecase;
    late MockRegisterCustomerRepository mockRepository;

    setUp(() {
      mockRepository = MockRegisterCustomerRepository();
      usecase = RegisterCustomerUsecase(repository: mockRepository);
    });

    test('should return RegisterCustomerResponse when the call is successful',
        () async {
      final customer = Customer(name: 'Test Customer', birthDate: '1970-01-01');
      final params = RegisterCustomerUsecaseParams(customer: customer);

      final customerId = 123;
      final creditAmount = 21.0;

      mockRepository.registerCustomerCallback = (customer) async {
        return Success(RegisterCustomerResponse(
            customerId: customerId, creditAmount: creditAmount));
      };

      final result = await usecase.call(params);

      result.fold(
        onError: (error) {
          fail('Expected a success result but got an error: $error');
        },
        onSuccess: (response) {
          expect(response, isA<RegisterCustomerResponse>());
          expect(response.creditAmount, creditAmount);
          expect(response.customerId, customerId);
        },
      );
    });

    test('should return DomainError when the call is unsuccessful', () async {
      final customer = Customer(name: 'Test Customer', birthDate: '1970-01-01');
      final params = RegisterCustomerUsecaseParams(customer: customer);

      mockRepository.registerCustomerCallback = (customer) async {
        return Error(DataError.badRequest('Bad request'));
      };

      final result = await usecase.call(params);

      result.fold(
        onError: (error) {
          expect(error, isA<DomainError>());
        },
        onSuccess: (response) {
          fail('Expected an error result but got a success: $response');
        },
      );
    });

    test('should return DomainError.invalidParams when params are null',
        () async {
      final result = await usecase.call(null);

      result.fold(
        onError: (error) {
          expect(error, isA<DomainError>());
          expect(error.message, DomainError.invalidParams().message);
        },
        onSuccess: (response) {
          fail('Expected an error result but got a success: $response');
        },
      );
    });
  });
}
