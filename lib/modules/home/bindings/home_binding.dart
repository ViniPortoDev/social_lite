import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../service/verify_phone_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio());
    Get.lazyPut(
      () => VerifyPhoneService(
        Get.find<Dio>(),
        apiKey: const String.fromEnvironment('apiKey'),
      ),
    );
    Get.lazyPut(() => HomeController(service: Get.find<VerifyPhoneService>()));
  }
}
