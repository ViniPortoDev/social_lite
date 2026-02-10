import 'package:get/get.dart';
import 'package:phone_validation_app/core/ui/dialogs/app_dialogs.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/local_notification_service.dart';
import '../../../core/services/auth_service.dart';

class SplashController extends GetxController {
  SplashController({
    required this.dialog,
    required this.authService,
    required this.notificationService,
  });
  final AppDialogs dialog;
  final AuthService authService;
  final LocalNotificationService notificationService;
  final isLoading = true.obs;
  final error = RxnString();

  @override
  void onReady() {
    super.onReady();
    _runGate();
  }

  Future<void> retry() async => _runGate();

  Future<void> _runGate() async {
    try {
      error.value = null;
      isLoading.value = true;

      await notificationService.init();

      final user = authService.currentUser;

      await Future.delayed(const Duration(milliseconds: 150));

      if (user == null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.home);
      }
    } catch (e) {
      error.value = 'Houve um erro ao iniciar o aplicativo. Tente novamente.';
    } finally {
      isLoading.value = false;
    }
  }
}
