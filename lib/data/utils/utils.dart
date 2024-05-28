import 'dart:convert';
import 'package:aplazo_app/data/error/data_error.dart';
import 'package:aplazo_app/domain/base/aplazo_result.dart';
import 'package:http/http.dart' as http;

AplazoResult<DataError, T> handleResponse<T>(
    http.Response response, T Function(Map<String, dynamic>) fromJson) {
  switch (response.statusCode) {
    case 200:
      final responseData = json.decode(response.body);
      return Success(fromJson(responseData));
    case 400:
      return Error(DataError.badRequest(response.body));
    case 404:
      return Error(DataError.notFound(response.body));
    case 500:
      return Error(DataError.serverError(response.body));
    default:
      return Error(DataError.unknown('${response.body}'));
  }
}

DataError handleException(e) {
  if (e is Exception) {
    return DataError.exception(e);
  } else {
    return DataError.unknown(e.toString());
  }
}
