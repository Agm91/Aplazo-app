import 'package:aplazo_app/data/error/data_error.dart';
import 'package:aplazo_app/data/local/purchase_database_service.dart';
import 'package:aplazo_app/domain/base/aplazo_result.dart';
import 'package:aplazo_app/data/network/register_purchase_service.dart';
import 'package:aplazo_app/data/utils/utils.dart';
import 'package:aplazo_app/domain/entities/purchase_entity.dart';
import 'package:aplazo_app/domain/models/purchase.dart';
import 'package:aplazo_app/domain/models/response/register_purchase_response.dart';

abstract class RegisterPurchaseRepository {
  Future<AplazoResult<DataError, RegisterPurchaseResponse>> registerPurchase(
      Purchase purchase);
}

class RegisterPurchaseRepositoryImpl implements RegisterPurchaseRepository {
  final RegisterPurchaseService registerPurchaseService;
  final PurchaseDatabaseService databaseService;

  RegisterPurchaseRepositoryImpl({
    required this.registerPurchaseService,
    required this.databaseService,
  });

  @override
  Future<AplazoResult<DataError, RegisterPurchaseResponse>> registerPurchase(
      Purchase purchase) async {
    try {
      final response = await registerPurchaseService.registerPurchase(purchase);

      final purchaseEntity = PurchaseEntity(
        customerId: purchase.customerId,
        amount: double.parse(purchase.purchaseAmount),
      );

      final result = handleResponse<RegisterPurchaseResponse>(
          response, (data) => RegisterPurchaseResponse.fromJson(data));

      if (result is Success) {
        await databaseService.insertPurchase(purchaseEntity);
      }
      return result;
    } catch (e) {
      return Error(handleException(e));
    }
  }
}
