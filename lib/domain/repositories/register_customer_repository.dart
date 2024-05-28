import 'package:aplazo_app/data/error/data_error.dart';
import 'package:aplazo_app/data/network/register_customer_service.dart';
import 'package:aplazo_app/domain/base/aplazo_result.dart';
import 'package:aplazo_app/data/utils/utils.dart';
import 'package:aplazo_app/domain/models/customer.dart';
import 'package:aplazo_app/domain/models/response/register_customer_response.dart';

abstract class RegisterCustomerRepository {
  Future<AplazoResult<DataError, RegisterCustomerResponse>> registerCustomer(Customer customer);
}

class RegisterCustomerRepositoryImpl extends RegisterCustomerRepository{
  final RegisterCustomerService _registerCustomerService;

  RegisterCustomerRepositoryImpl({required RegisterCustomerService registerCustomerService}) : _registerCustomerService = registerCustomerService;

  @override
  Future<AplazoResult<DataError, RegisterCustomerResponse>> registerCustomer(Customer customer) async {
    try{
      final response = await _registerCustomerService.registerCustomer(customer);

      return handleResponse<RegisterCustomerResponse>(
        response, (data) => RegisterCustomerResponse.fromJson(data)
      );
    }catch(e){
      return Error(handleException(e));
    }
  }
}