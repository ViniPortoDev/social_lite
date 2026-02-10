import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../core/services/local_notification_service.dart';
import '../../core/ui/dialogs/app_dialogs.dart';
import '../../core/services/auth_service.dart';
import '../../modules/auth/services/user_db_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Core UI
    Get.lazyPut(() => AppDialogs(), fenix: true);

    // Firebase singletons
    Get.lazyPut(() => FirebaseAuth.instance, fenix: true);
    Get.lazyPut(() => FirebaseFirestore.instance, fenix: true);

    // Shared services
    Get.lazyPut(() => AuthService(Get.find<FirebaseAuth>()), fenix: true);
    Get.lazyPut(
      () => UserDbService(Get.find<FirebaseFirestore>()),
      fenix: true,
    );
    Get.lazyPut(() => LocalNotificationService(), fenix: true);
  }
}
