import 'package:get/get.dart';
import '../../../core/ui/dialogs/app_dialogs.dart';
import '../../../core/services/local_notification_service.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../models/comment_model.dart';
import '../models/feed_post_model.dart';
import '../models/photo_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
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
  final feed = <FeedPostModel>[].obs;

  final _likedPostIds = <int>{}.obs;
  final _savedPostIds = <int>{}.obs;

  bool isLiked(int postId) => _likedPostIds.contains(postId);
  bool isSaved(int postId) => _savedPostIds.contains(postId);

  void toggleLike(int postId) {
    if (_likedPostIds.contains(postId)) {
      _likedPostIds.remove(postId);
    } else {
      _likedPostIds.add(postId);
    }
  }

  void toggleSave(int postId) {
    if (_savedPostIds.contains(postId)) {
      _savedPostIds.remove(postId);
    } else {
      _savedPostIds.add(postId);
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchFeed();
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

  Future<void> fetchFeed() async {
    try {
      isLoading.value = true;

      final results = await Future.wait([
        api.fetchPosts(limit: 100),
        api.fetchUsers(),
        api.fetchComments(limit: 20),
        api.fetchPhotos(limit: 50),
      ]);

      final allPosts = results[0] as List<PostModel>;
      final users = results[1] as List<UserModel>;
      final comments = results[2] as List<CommentModel>;
      final photos = results[3] as List<PhotoModel>;

      final byUser = <int, List<PostModel>>{};
      for (final p in allPosts) {
        (byUser[p.userId] ??= <PostModel>[]).add(p);
      }

      final selectedPosts = <PostModel>[];
      for (final u in users) {
        final list = byUser[u.id];
        if (list == null || list.isEmpty) continue;
        selectedPosts.addAll(list.take(2));
      }
      if (selectedPosts.isEmpty) {
        selectedPosts.addAll(allPosts.take(20));
      }

      posts.assignAll(selectedPosts);

      if (selectedPosts.isEmpty || users.isEmpty || photos.isEmpty) {
        feed.clear();
        return;
      }

      final userById = {for (final u in users) u.id: u};

      final commentsByPostId = <int, List<CommentModel>>{};
      for (final c in comments) {
        (commentsByPostId[c.postId] ??= <CommentModel>[]).add(c);
      }

      PhotoModel pickPostPhoto(int postId) {
        final idx = (postId - 1) % photos.length;
        return photos[idx];
      }

      PhotoModel pickProfilePhoto(int userId) {
        final idx = (userId - 1) % photos.length;
        return photos[idx];
      }

      final items = selectedPosts
          .map((p) {
            final u =
                userById[p.userId] ?? users[(p.userId - 1) % users.length];
            final postPhoto = pickPostPhoto(p.id);
            final profilePhoto = pickProfilePhoto(u.id);
            final postComments =
                commentsByPostId[p.id] ?? const <CommentModel>[];

            return FeedPostModel(
              post: p,
              user: u,
              profilePhoto: profilePhoto,
              postPhoto: postPhoto,
              comments: postComments,
            );
          })
          .toList(growable: false);

      feed.assignAll(items);

      if (items.isNotEmpty) {
        await notificationService.init();
        await notificationService.showNewData(newCount: items.length);
      }
    } catch (e) {
      dialog.showError(
        title: 'Erro ao carregar',
        message:
            'Não foi possível montar o feed agora. Verifique sua conexão e tente novamente.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> testImmediateNotification() async {
    await notificationService.showNewData(newCount: posts.length);
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
