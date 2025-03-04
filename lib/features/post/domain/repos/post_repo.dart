import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/core/errors/failure.dart';

import '../../../auth/models/user_model.dart';
import '../../data/models/post_model.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> createPost({
    required UserModel userModel,
    List<String>? postMediaUrl,
    String? postTitle,
  });

  Future<Either<Failure, List<PostModel>>> fetchPosts(
      {int limit = 10});

  Future<Either<Failure, void>> toggleLike(String postId, String userId);

  Future<Either<Failure, List<String>>> uploadPostMedia({
    required String userId,
    required List<XFile> media,
  });

  Future<Either<Failure, int>> fetchLikesCount(String postId);
}
