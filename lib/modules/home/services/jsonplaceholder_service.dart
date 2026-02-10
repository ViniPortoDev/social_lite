import 'package:dio/dio.dart';
import '../models/comment_model.dart';
import '../models/photo_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class JsonPlaceholderService {
  JsonPlaceholderService(this._dio);

  final Dio _dio;

  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<T>> _getList<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final uri = '$_baseUrl$path';
    final response = await _dio.get(
      uri,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (_) => true,
        headers: {'Accept': 'application/json'},
        responseType: ResponseType.json,
      ),
    );

    final status = response.statusCode ?? 0;
    if (status < 200 || status >= 300) {
      throw Exception('HTTP $status em $uri');
    }

    final data = response.data;
    if (data is! List) {
      throw Exception('Resposta inesperada da API em $uri.');
    }

    return data.whereType<Map<String, dynamic>>().map(fromJson).toList();
  }

  Future<List<PostModel>> fetchPosts({int? limit, int? start}) async {
    return _getList<PostModel>(
      path: '/posts',
      queryParameters: {
        if (limit != null) '_limit': limit,
        if (start != null) '_start': start,
      },
      fromJson: PostModel.fromJson,
    );
  }

  Future<List<UserModel>> fetchUsers() async {
    return _getList<UserModel>(path: '/users', fromJson: UserModel.fromJson);
  }

  Future<List<CommentModel>> fetchComments({int? limit, int? start}) async {
    return _getList<CommentModel>(
      path: '/comments',
      queryParameters: {
        if (limit != null) '_limit': limit,
        if (start != null) '_start': start,
      },
      fromJson: CommentModel.fromJson,
    );
  }

  Future<List<PhotoModel>> fetchPhotos({int limit = 200, int start = 0}) async {
    return _getList<PhotoModel>(
      path: '/photos',
      queryParameters: {'_limit': limit, '_start': start},
      fromJson: PhotoModel.fromJson,
    );
  }
}
