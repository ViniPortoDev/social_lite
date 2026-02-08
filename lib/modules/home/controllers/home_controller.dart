import 'package:get/get.dart';
import '../models/phone_validation_result.dart';
import '../service/verify_phone_service.dart';

class HomeController extends GetxController {
  HomeController({required this.service});

  final VerifyPhoneService service;

  final isLoading = false.obs;
  final error = RxnString();
  final result = Rxn<PhoneValidationResult>();

  Future<void> validatePhone({
    required String phone,
    String defaultCountry = 'BR',
  }) async {
    try {
      error.value = null;
      result.value = null;
      isLoading.value = true;

      final r = await service.verify(phone: phone, defaultCountry: defaultCountry);
      result.value = r;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
