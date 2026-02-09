import 'comment_model.dart';
import 'photo_model.dart';
import 'post_model.dart';
import 'user_model.dart';

class FeedPostModel {
  final PostModel post;
  final UserModel user;
  final PhotoModel profilePhoto;
  final PhotoModel postPhoto;
  final List<CommentModel> comments;

  FeedPostModel({
    required this.post,
    required this.user,
    required this.profilePhoto,
    required this.postPhoto,
    required this.comments,
  });
}

