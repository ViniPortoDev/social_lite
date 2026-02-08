import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
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

      final user = FirebaseAuth.instance.currentUser;

      await Future.delayed(const Duration(milliseconds: 150));

      if (user == null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.home);
      }
    } catch (e) {
      error.value = 'Falha ao iniciar: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
