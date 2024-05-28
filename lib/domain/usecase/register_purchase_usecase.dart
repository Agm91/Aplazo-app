import 'package:aplazo_app/domain/base/aplazo_result.dart';
import 'package:aplazo_app/domain/base/base_usecase.dart';
import 'package:aplazo_app/domain/error/domain_error.dart';
import 'package:aplazo_app/domain/models/purchase.dart';
import 'package:aplazo_app/domain/models/response/register_purchase_response.dart';
import 'package:aplazo_app/domain/repositories/register_purchase_repository.dart';

class RegisterPurchaseUsecaseParams {
  final Purchase purchase;

  RegisterPurchaseUsecaseParams({required this.purchase});
}

class RegisterPurchaseUsecase extends BaseUseCase<
    AplazoResult<DomainError, RegisterPurchaseResponse>,
    RegisterPurchaseUsecaseParams> {
  final RegisterPurchaseRepository _repository;

  RegisterPurchaseUsecase({
    required RegisterPurchaseRepository repository,
  }) : _repository = repository;

  @override
  Future<AplazoResult<DomainError, RegisterPurchaseResponse>> call(
      RegisterPurchaseUsecaseParams? params) async {
    if (params == null) {
      return Error(DomainError.invalidParams());
    }

    final result = await _repository.registerPurchase(params.purchase);

    return result.fold(
        onError: (error) => Error(toDomainError(error)),
        onSuccess: (registerCustomerResponse) =>
            Success(registerCustomerResponse));
  }
}
