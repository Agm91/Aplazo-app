import 'package:aplazo_app/domain/models/purchase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';

abstract class RegisterPurchaseService {
  Future<http.Response> registerPurchase(Purchase purchase);
}

class RegisterPurchaseServiceImpl extends RegisterPurchaseService {
  final http.Client client = http.Client();

  @override
  Future<http.Response> registerPurchase(Purchase purchase) async {
    final response = await client.post(
      Uri.parse('${Config.apiUrl}/api/purchases/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(purchase.toJson()),
    );
    return response;
  }
}
