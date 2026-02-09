import 'package:dio/dio.dart';
import '../models/post_model.dart';

class JsonPlaceholderService {
  JsonPlaceholderService(this._dio);

  final Dio _dio;

  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<PostModel>> fetchPosts() async {
    final response = await _dio.get('$_baseUrl/posts');
    final data = response.data;

    if (data is! List) {
      throw Exception('Resposta inesperada da API.');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(PostModel.fromJson)
        .toList();
  }
}
