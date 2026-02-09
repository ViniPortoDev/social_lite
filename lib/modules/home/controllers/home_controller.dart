import 'package:get/get.dart';
import '../../../core/ui/dialogs/app_dialogs.dart';
import '../../../core/services/local_notification_service.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../models/post_model.dart';
import '../services/jsonplaceholder_service.dart';

class HomeController extends GetxController {
  HomeController({
    required this.api,
    required this.notificationService,
    required this.dialog,
    required this.authService,
  });

  final JsonPlaceholderService api;
  final LocalNotificationService notificationService;
  final AppDialogs dialog;
  final AuthService authService;

  final isLoading = false.obs;
  final isLoggingOut = false.obs;
  final posts = <PostModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final data = await api.fetchPosts();
      posts.assignAll(data);

      if (data.isNotEmpty) {
        await notificationService.showNewData(newCount: data.length);
      }
    } catch (e) {
      dialog.showError(
        title: 'Erro ao carregar',
        message: 'Não foi possível buscar os posts agora. Tente novamente.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> testImmediateNotification() async {
    await notificationService.showNewData(newCount: posts.length);
    Get.snackbar('Notificação enviada!', 'Verifique a barra de notificações');
  }

  Future<void> testScheduledNotification() async {
    await notificationService.scheduleTest(seconds: 10);
    Get.snackbar(
      'Notificação agendada!',
      'Será exibida em 10 segundos',
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> logout() async {
    try {
      final shouldLogout = await dialog.confirm(
        title: 'Sair',
        message: 'Deseja realmente sair da sua conta?',
        confirmText: 'Sair',
        cancelText: 'Cancelar',
      );
      if (!shouldLogout) return;

      isLoggingOut.value = true;
      await authService.signOut();
      Get.offAllNamed(Routes.splash);
    } catch (e) {
      dialog.showError(
        title: 'Erro ao sair',
        message: 'Não foi possível sair agora. Tente novamente.',
      );
    } finally {
      isLoggingOut.value = false;
    }
  }
}
