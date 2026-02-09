import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/ui/dialog_service.dart';
import '../controllers/auth_controller.dart';
import '../controllers/register_controller.dart';
import '../services/auth_service.dart';
import '../services/user_db_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => AuthService(Get.find<FirebaseAuth>()));
    Get.lazyPut(() => DialogService());
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut(() => UserDbService(Get.find<FirebaseFirestore>()));

    Get.lazyPut(
      () => AuthController(
        authService: Get.find<AuthService>(),
        dialog: Get.find<DialogService>(),
      ),
    );
    Get.lazyPut(
      () => RegisterController(
        authService: Get.find<AuthService>(),
        dialog: Get.find<DialogService>(),
        userDb: Get.find<UserDbService>(),
      ),
    );
  }
}
