import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/core/errors/failure.dart';

import '../../../auth/models/user_model.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';

abstract class PostRepo {
  Future<Either<Failure, PostModel>> createPost({
    required UserModel userModel,
    List<String>? postMediaUrl,
    String? postTitle,
  });

  Future<Either<Failure, List<PostModel>>> fetchPosts({
    int limit = 10,
    bool reset = false,
  });

  Future<Either<Failure, bool>> toggleLike(String postId, String userId);

  Future<Either<Failure, String>> createComment(
      {required String postId,
      required String userId,
      required String comment});

  Future<Either<Failure, List<CommentModel>>> fetchComments(String postId);

  Future<Either<Failure, List<String>>> uploadPostMedia({
    required String userId,
    required List<XFile> media,
  });

  Future<Either<Failure, int>> fetchLikesCount(String postId);
}
