import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/features/post/domain/repos/post_repo.dart';
import '../../../../constants.dart';
import '../../../auth/models/user_model.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';
import '../../domain/use_cases/create_post_use_case.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.createPostUseCase, this.postRepo) : super(PostInitial());
  final CreatePostUseCase createPostUseCase;
  final PostRepo postRepo;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(kUsersCollection);

  static PostCubit get(context) => BlocProvider.of(context);
  List<XFile>? media;

  Future<void> pickPostFiles() async {
    try {
      final ImagePicker picker = ImagePicker();

      final pickedMedia = await picker.pickMultipleMedia();

      if (pickedMedia.isNotEmpty) {
        media = pickedMedia;
        emit(PostFilesPickedSuccess());
      } else {
        emit(PostFilesPickedFailure('No media files were selected.'));
      }
    } catch (e) {
      emit(PostFilesPickedFailure(
          'An error occurred while picking media files.'));
    }
  }

  Future<void> fetchLikesCount(String postId) async {
    final result = await postRepo.fetchLikesCount(postId);
    result.fold((failure) {
      emit(FetchLikesCountFailure(failure.message));
    }, (likesCount) {
      emit(FetchLikesCountSuccess(likesCount, postId));
    });
  }

  Future<void> toggleLike(String postId, String userId) async {
    _fastToggleLike(postId);
    final result = await postRepo.toggleLike(postId, userId);
    result.fold((failure) {
      emit(ToggleLikeFailure(failure.message));
    }, (like) {
      // if (like) {
      //   likedPostsMap[postId] = allPostsMap[postId]!;
      // }
      // else {
      //   likedPostsMap.remove(postId);
      // }
      emit(ToggleLikeSuccess(postId));
    });
  }

  /// for better user experience
  void _fastToggleLike(String postId) {
    likedPostsMap[postId] != null
        ? likedPostsMap.remove(postId)
        : likedPostsMap[postId] = allPostsMap[postId]!;
    emit(FastToggleLike());
  }

  Map<String, PostModel> allPostsMap = {};

  Map<String, PostModel> likedPostsMap = {};

  Map<String, UserModel> postsUsers = {};

  Future<void> fetchPosts({
    int limit = 10,
    bool reset = false,
  }) async {
    emit(GetPostsLoading());
    var result = await postRepo.fetchPosts(limit: limit, reset: reset);
    result.fold((failure) {
      emit(GetPostsFailure(failure.message));
    }, (posts) async {
      await _getPostsUsers(posts);
      await organizeLikedPosts(posts);
      emit(GetPostsSuccess(posts));
    });
  }

  Future<void> organizeLikedPosts(List<PostModel> posts) async {
    for (var post in posts) {
      if (post.isLiked) {
        likedPostsMap[post.postId] = post;
      }
    }
  }

  Future<void> _getPostsUsers(List<PostModel> posts) async {
    for (var post in posts) {
      final userId = post.uId;
      if (!postsUsers.containsKey(userId)) {
        final userDoc = await _usersCollection.doc(userId).get();
        final userModel =
            UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        postsUsers[userId] = userModel;
      }
    }
  }

  final TextEditingController commentController = TextEditingController();

  Future<void> createComment({
    required String postId,
    required String userId,
  }) async {
    emit(CreateCommentLoading());
    final result = await postRepo.createComment(
        postId: postId, userId: userId, comment: commentController.text);
    result.fold((failure) {
      emit(CreateCommentFailure(failure.message));
    }, (comment) {
      emit(CreateCommentSuccess(comment));
    });
  }

  Future<void> fetchComments(String postId) async {
    emit(FetchCommentsLoading());
    final result = await postRepo.fetchComments(postId);
    result.fold((failure) {
      emit(FetchCommentsFailure(failure.message));
    }, (comments) async {
      await getCommentsUsers(comments);
      emit(FetchCommentsSuccess(comments));
    });
  }

  Future<void> getCommentsUsers(List<CommentModel> comments) async {
    for (var comment in comments) {
      if (postsUsers.containsKey(comment.userId)) continue;
      final userDoc = await _usersCollection.doc(comment.userId).get();
      final userModel =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      postsUsers[comment.userId] = userModel;
    }
  }

  TextEditingController postTitleController = TextEditingController();

  Future<void> createPost(UserModel userModel) async {
    emit(CreatePostLoading());
    var result = await createPostUseCase.call(
        userModel, media, postTitleController.text);
    result.fold((failure) {
      emit(CreatePostFailure(failure.message));
    }, (r) {
      media = null;
      emit(CreatePostSuccess());
    });
  }

  void checkPostStatus() {
    if (postTitleController.text.trim().isEmpty &&
        (media == null || media!.isEmpty)) {
      emit(CanNotUploadPost());
    } else {
      emit(CanUploadPost());
    }
  }

  void checkCommentStatus() {
    if (commentController.text.trim().isEmpty) {
      emit(CanNotComment());
    } else {
      emit(CanComment());
    }
  }
}
