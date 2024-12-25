
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/core/errors/failure.dart';

import '../../../auth/models/user_model.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> createPost({
    required UserModel userModel,
    String? postImageUrl,
    String? postTitle,
  });

  Future<Either<Failure, List<XFile>>> pickPostFiles();

  Future<Either<Failure, void>> fetchPosts();

  Future<Either<Failure, void>> likePost(String postId);
}
