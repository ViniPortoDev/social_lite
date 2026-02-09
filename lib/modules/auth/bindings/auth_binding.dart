import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/register_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthController(
        authService: Get.find(),
        dialog: Get.find(),
      ),
    );
    Get.lazyPut(
      () => RegisterController(
        authService: Get.find(),
        dialog: Get.find(),
        userDb: Get.find(),
      ),
    );
  }
}
