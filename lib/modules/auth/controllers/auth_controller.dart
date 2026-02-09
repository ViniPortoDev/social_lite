import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/errors/firebase_auth_error_mapper.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/ui/dialogs/app_dialogs.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  AuthController({required this.authService, required this.dialog});

  final AuthService authService;
  final AppDialogs dialog;

  final isLoading = false.obs;

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

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await authService.signOut();
      Get.offAllNamed(Routes.splash);
    } catch (e) {
      dialog.showError(
        title: 'Erro ao sair',
        message: 'Não foi possível sair agora. Tente novamente.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
