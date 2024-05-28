import 'package:aplazo_app/data/error/data_error.dart';
import 'package:aplazo_app/domain/base/aplazo_result.dart';
import 'package:aplazo_app/domain/error/domain_error.dart';
import 'package:aplazo_app/domain/models/purchase.dart';
import 'package:aplazo_app/domain/models/response/register_purchase_response.dart';
import 'package:aplazo_app/domain/repositories/register_purchase_repository.dart';
import 'package:aplazo_app/domain/usecase/register_purchase_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRegisterPurchaseRepository implements RegisterPurchaseRepository {
  Future<AplazoResult<DataError, RegisterPurchaseResponse>> Function(
      Purchase purchase)? registerPurchaseCallback;

  @override
  Future<AplazoResult<DataError, RegisterPurchaseResponse>> registerPurchase(
      Purchase purchase) async {
    if (registerPurchaseCallback != null) {
      return registerPurchaseCallback!(purchase);
    } else {
      throw UnimplementedError();
    }
  }
}

void main() {
  group('RegisterPurchaseUsecase', () {
    late RegisterPurchaseUsecase usecase;
    late MockRegisterPurchaseRepository mockRepository;

    setUp(() {
      mockRepository = MockRegisterPurchaseRepository();
      usecase = RegisterPurchaseUsecase(repository: mockRepository);
    });

    test('should return RegisterPurchaseResponse when the call is successful',
        () async {
      final purchase = Purchase(customerId: '1', purchaseAmount: '100.0');
      final params = RegisterPurchaseUsecaseParams(purchase: purchase);

      final purchaseId = 123;

      mockRepository.registerPurchaseCallback = (purchase) async {
        return Future.value(
            Success(RegisterPurchaseResponse(purchaseId: purchaseId)));
      };

      final result = await usecase.call(params);

      result.fold(
        onError: (error) {
          fail('Expected a success result but got an error: $error');
        },
        onSuccess: (response) {
          expect(response, isA<RegisterPurchaseResponse>());
          expect(response.purchaseId, purchaseId);
        },
      );
    });

    test('should return DomainError when the call is unsuccessful', () async {
      final purchase = Purchase(customerId: '1', purchaseAmount: '100');
      final params = RegisterPurchaseUsecaseParams(purchase: purchase);

      mockRepository.registerPurchaseCallback = (purchase) async {
        return Future.value(Error(DataError.badRequest('Bad request')));
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
