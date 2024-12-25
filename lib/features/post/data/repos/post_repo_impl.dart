import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/post_repo.dart';
import '../models/post_model.dart';

class PostRepoImpl extends PostRepo {
  @override
  Future<Either<Failure, void>> createPost({
    required UserModel userModel,
    String? postImageUrl,
    String? postTitle,
  }) async {
    try {
      final userDocRef = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userModel.uId);
      final docRef = userDocRef.collection(kPostsCollection).doc();
      final postModel = PostModel(
        postId: docRef.id,
        userProfileImage: userModel.profileImageUrl,
        postFileUrl: postImageUrl ?? '',
        postTitle: postTitle ?? '',
        userName: userModel.name,
        uId: userModel.uId!,
        createdAt: DateTime.now(),
      );
      await docRef.set(postModel.toJson());
      return right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // waiting for creating followings collection and for data sources classes to be implemented
  @override
  Future<Either<Failure, void>> fetchPosts() {
    // TODO: implement fetchPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> likePost(String postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<XFile>>> pickPostFiles() async {
    try {
      final ImagePicker picker = ImagePicker();

      final List<XFile> media = await picker.pickMultipleMedia();

      if (media.isNotEmpty) {
        return right(media);
      }
      return const Left(Failure('No media files were selected.'));
    } catch (e) {
      return const Left(
          Failure('An error occurred while picking media files.'));
    }
  }
}
