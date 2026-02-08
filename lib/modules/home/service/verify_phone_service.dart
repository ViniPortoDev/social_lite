import 'package:dio/dio.dart';
import '../models/phone_validation_result.dart';

class VerifyPhoneService {
  VerifyPhoneService(this._dio, {required this.apiKey});

  final Dio _dio;
  final String apiKey;

  static const _baseUrl = 'https://veriphone.io/v2';

  Future<PhoneValidationResult> verify({
    required String phone,
    String defaultCountry = 'BR',
  }) async {
    if (apiKey.isEmpty) {
      throw Exception('apiKey não configurada.');
    }

    final resp = await _dio.get(
      '$_baseUrl/verify',
      queryParameters: {
        'phone': phone,
        'default_country': defaultCountry,
        'key': apiKey,
      },
      options: Options(headers: {'Accept': 'application/json'}),
    );

    final data = resp.data;
    if (data is! Map<String, dynamic>) {
      throw Exception('Resposta inesperada da API.');
    }

    return PhoneValidationResult.fromJson(data);
  }
}
