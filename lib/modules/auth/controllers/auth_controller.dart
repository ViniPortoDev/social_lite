import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  AuthController({required this.authService});

  final AuthService authService;

  final isLoading = false.obs;
  final error = RxnString();

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      error.value = null;
      isLoading.value = true;

      await authService.signInWithEmail(email: email.trim(), password: password);

      Get.offAllNamed(Routes.home);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
