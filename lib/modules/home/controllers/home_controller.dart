import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/jsonplaceholder_service.dart';

class HomeController extends GetxController {
  HomeController({required this.api});

  final JsonPlaceholderService api;

  final isLoading = false.obs;
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
    } finally {
      isLoading.value = false;
    }
  }
}
