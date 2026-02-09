import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../services/jsonplaceholder_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio());
    Get.lazyPut(() => JsonPlaceholderService(Get.find<Dio>()));
    Get.lazyPut(() => HomeController(api: Get.find<JsonPlaceholderService>()));
  }
}
