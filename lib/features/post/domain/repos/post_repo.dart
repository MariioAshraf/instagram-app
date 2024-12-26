import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/core/errors/failure.dart';

import '../../../auth/models/user_model.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> createPost({
    required UserModel userModel,
    List<String>? postMediaUrl,
    String? postTitle,
  });

  Future<Either<Failure, void>> fetchPosts();

  Future<Either<Failure, void>> likePost(String postId);

  Future<Either<Failure, List<String>>> uploadPostMedia({
    required String userId,
    required List<XFile> media,
  });
}
