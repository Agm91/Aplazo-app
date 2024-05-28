import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/models/customer.dart';
import '../../config.dart';

abstract class RegisterCustomerService {
  Future<http.Response> registerCustomer(Customer customer);
}

class RegisterCustomerServiceImp extends RegisterCustomerService {
  final http.Client client = http.Client();

  @override
  Future<http.Response> registerCustomer(Customer customer) async {
    final response = await client.post(
      Uri.parse('${Config.apiUrl}/api/customers/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(customer.toJson()),
    );

    return response;
  }
}
