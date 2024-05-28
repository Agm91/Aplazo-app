import 'package:aplazo_app/domain/base/aplazo_result.dart';
import 'package:aplazo_app/domain/base/base_usecase.dart';
import 'package:aplazo_app/domain/error/domain_error.dart';
import 'package:aplazo_app/domain/models/customer.dart';
import 'package:aplazo_app/domain/models/response/register_customer_response.dart';
import 'package:aplazo_app/domain/repositories/register_customer_repository.dart';

class RegisterCustomerUsecaseParams {
  final Customer customer;

  RegisterCustomerUsecaseParams({required this.customer});
}

class RegisterCustomerUsecase extends BaseUseCase<AplazoResult<DomainError, RegisterCustomerResponse>, RegisterCustomerUsecaseParams>  {
  final RegisterCustomerRepository _repository;

  RegisterCustomerUsecase({
    required RegisterCustomerRepository repository,
  }) : _repository = repository;

  @override
  Future<AplazoResult<DomainError, RegisterCustomerResponse>> call(RegisterCustomerUsecaseParams? params) async {
    if(params == null){
      return Error(DomainError.invalidParams());
    }
    
    final result = await _repository.registerCustomer(params.customer);

    return result.fold(
      onError: (error) => Error(toDomainError(error)),
      onSuccess: (registerPurchaseResponse) => Success(registerPurchaseResponse)
    );
  }
}