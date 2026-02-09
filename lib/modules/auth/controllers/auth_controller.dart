import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/errors/firebase_auth_error_mapper.dart';
import '../../../core/ui/dialog_service.dart';
import '../../../routes/app_routes.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  AuthController({required this.authService, required this.dialog});

  final AuthService authService;
  final DialogService dialog;

  final isLoading = false.obs;
  final error = RxnString();

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      await authService.signInWithGoogle();
      Get.offAllNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      dialog.showError(
        title: FirebaseAuthErrorMapper.title(e),
        message: FirebaseAuthErrorMapper.message(e),
      );
    } catch (e) {
      dialog.showError(
        title: 'Erro inesperado',
        message: 'Não foi possível concluir o login. Tente novamente.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      error.value = null;
      isLoading.value = true;

      await authService.signInWithEmail(
        email: email.trim(),
        password: password,
      );

      Get.offAllNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      dialog.showError(
        title: FirebaseAuthErrorMapper.title(e),
        message: FirebaseAuthErrorMapper.message(e),
      );
    } catch (e) {
      dialog.showError(
        title: 'Erro inesperado',
        message: 'Não foi possível concluir o login. Tente novamente.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
