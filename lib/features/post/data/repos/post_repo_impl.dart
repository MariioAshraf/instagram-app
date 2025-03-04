import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/post_repo.dart';
import '../models/post_model.dart';

class PostRepoImpl extends PostRepo {
  final _postsCollection =
      FirebaseFirestore.instance.collection(kPostsCollection);

  DocumentSnapshot? _lastDocument;

  @override
  Future<Either<Failure, void>> createPost({
    required UserModel userModel,
    List<String>? postMediaUrl,
    String? postTitle,
  }) async {
    try {
      final docRef = _postsCollection.doc();
      final postModel = PostModel(
        postId: docRef.id,
        userProfileImage: userModel.profileImageUrl,
        postFileUrl: postMediaUrl ?? [],
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
  Future<Either<Failure, List<PostModel>>> fetchPosts({
    int limit = 5,
  }) async {
    try {
      Query query =
          _postsCollection.orderBy(kCreatedAt, descending: true).limit(limit);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }
      final querySnapshot = await query.get();
      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last; // update last document
      }

      return Right(querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleLike(String postId, String userId) async {
    try {
      final likeRef =
          _postsCollection.doc(postId).collection(kLikesCollection).doc(userId);

      final likeDoc = await likeRef.get();

      if (likeDoc.exists) {
        await _unLikePost(likeRef, postId);
      } else {
        await _likePost(likeRef, postId);
      }

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> _unLikePost(
      DocumentReference<Map<String, dynamic>> likeRef, String postId) async {
    await likeRef.delete();
    await _postsCollection.doc(postId).update({
      kLikesCount: FieldValue.increment(-1),
    });
  }

  Future<void> _likePost(
      DocumentReference<Map<String, dynamic>> likeRef, String postId) async {
    await likeRef.set({kLiked: true});
    await _postsCollection.doc(postId).update({
      kLikesCount: FieldValue.increment(1),
    });
  }

  @override
  Future<Either<Failure, List<String>>> uploadPostMedia({
    required String userId,
    required List<XFile> media,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      final List<String> fileUrls = [];

      for (var i = 0; i < media.length; i++) {
        final file = File(media[i].path);
        final String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
        final String fullPath = '$kPostsCollection/$userId/$fileName';
        await supabase.storage.from(kPostsCollection).upload(
              fullPath,
              file,
            );

        final String fileUrl =
            supabase.storage.from(kPostsCollection).getPublicUrl(fullPath);
        fileUrls.add(fileUrl);
      }
      return Right(fileUrls);
    } catch (e) {
      return Left(
          Failure('An error occurred while uploading media: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> fetchLikesCount(String postId) async {
    try {
      final postDoc = await _postsCollection.doc(postId).get();
      return Right(postDoc.data()?[kLikesCount] ?? 0);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
