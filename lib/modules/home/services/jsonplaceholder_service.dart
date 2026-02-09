import 'package:dio/dio.dart';
import '../models/comment_model.dart';
import '../models/photo_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class JsonPlaceholderService {
  JsonPlaceholderService(this._dio);

  final Dio _dio;

  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<PostModel>> fetchPosts({int? limit, int? start}) async {
    final response = await _dio.get(
      '$_baseUrl/posts',
      queryParameters: {
        if (limit != null) '_limit': limit,
        if (start != null) '_start': start,
      },
    );
    final data = response.data;

    if (data is! List) {
      throw Exception('Resposta inesperada da API.');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(PostModel.fromJson)
        .toList();
  }

  Future<List<UserModel>> fetchUsers() async {
    final response = await _dio.get('$_baseUrl/users');
    final data = response.data;

    if (data is! List) {
      throw Exception('Resposta inesperada da API.');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(UserModel.fromJson)
        .toList();
  }

  Future<List<CommentModel>> fetchComments({int? limit, int? start}) async {
    final response = await _dio.get(
      '$_baseUrl/comments',
      queryParameters: {
        if (limit != null) '_limit': limit,
        if (start != null) '_start': start,
      },
    );
    final data = response.data;

    if (data is! List) {
      throw Exception('Resposta inesperada da API.');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(CommentModel.fromJson)
        .toList();
  }

  Future<List<PhotoModel>> fetchPhotos({int limit = 200, int start = 0}) async {
    final response = await _dio.get(
      '$_baseUrl/photos',
      queryParameters: {'_limit': limit, '_start': start},
    );
    final data = response.data;

    if (data is! List) {
      throw Exception('Resposta inesperada da API.');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(PhotoModel.fromJson)
        .toList();
  }
}
