import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/post/data/models/comment_model.dart';
import 'package:instagram_app/features/post/data/post_model_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/post_repo.dart';
import '../models/post_model.dart';

class PostRepoImpl extends PostRepo {
  final _postsCollection =
      FirebaseFirestore.instance.collection(kPostsCollection);

  DocumentSnapshot? _lastDocument;

  @override
  Future<Either<Failure, PostModel>> createPost({
    required UserModel userModel,
    List<String>? postMediaUrl,
    String? postTitle,
  }) async {
    try {
      final docRef = _postsCollection.doc();
      final postModel = PostModel(
        postId: docRef.id,
        postFileUrl: postMediaUrl ?? [],
        postTitle: postTitle ?? '',
        userName: userModel.name,
        uId: userModel.uId!,
        createdAt: DateTime.now(),
      );
      await docRef.set(postModel.toJson());
      return right(postModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // waiting for creating followings collection and for data sources classes to be implemented
  @override
  Future<Either<Failure, List<PostModel>>> fetchPosts({
    int limit = 10,
    bool reset = false,
    required String userId,
  }) async {
    try {
      if (reset) {
        _lastDocument = null;
      }

      Query query =
          _postsCollection.orderBy(kCreatedAt, descending: true).limit(limit);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;
      }

      List<PostModel> posts = [];

      for (var doc in querySnapshot.docs) {
        var likesCollection = doc.reference.collection(kLikesCollection);

        var userLikeDoc = await likesCollection.doc(userId).get();
        bool isLiked = userLikeDoc.exists;

        var post = PostModel.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(isLiked: isLiked);

        posts.add(post);
      }

      return Right(posts);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleLike(String postId, String userId) async {
    late bool like; // this bool not used but it still a good approach
    try {
      final likeRef =
          _postsCollection.doc(postId).collection(kLikesCollection).doc(userId);

      final likeDoc = await likeRef.get();

      if (likeDoc.exists) {
        await _unLikePost(likeRef, postId);
        like = false;
      } else {
        await _likePost(likeRef, postId);
        like = true;
      }
      return right(like);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> _unLikePost(
      DocumentReference<Map<String, dynamic>> likeRef, String postId) async {
    await likeRef.delete();
    await _postsCollection
        .doc(postId)
        .update({kLikesCount: FieldValue.increment(-1), kIsLiked: false});
  }

  Future<void> _likePost(
      DocumentReference<Map<String, dynamic>> likeRef, String postId) async {
    await likeRef.set({kLiked: true});
    await _postsCollection
        .doc(postId)
        .update({kLikesCount: FieldValue.increment(1), kIsLiked: true});
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

  @override
  Future<Either<Failure, String>> createComment(
      {required String postId,
      required String userId,
      required String comment}) async {
    try {
      final commentRef =
          _postsCollection.doc(postId).collection(kCommentsCollection).doc();

      final commentModel = CommentModel(
          commentId: commentRef.id,
          userId: userId,
          comment: comment,
          createdAt: DateTime.now());

      await commentRef.set(commentModel.toJson());
      _postsCollection.doc(postId).update({
        kCommentsCount: FieldValue.increment(1),
      });

      return Right(comment);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> fetchComments(
      String postId) async {
    try {
      final List<CommentModel> comments = [];
      final commentsCollection = await _postsCollection
          .doc(postId)
          .collection(kCommentsCollection)
          .get();
      for (var doc in commentsCollection.docs) {
        comments.add(CommentModel.fromJson(doc.data()));
      }

      return Right(
          comments..sort((k1, k2) => k2.createdAt.compareTo(k1.createdAt)));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
