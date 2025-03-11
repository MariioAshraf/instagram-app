import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants.dart';
import '../../../../auth/models/user_model.dart';
import '../../../data/models/post_model.dart';
import '../../../domain/repos/post_repo.dart';

part 'get_post_state.dart';

class GetPostCubit extends Cubit<GetPostState> {
  GetPostCubit(this.postRepo) : super(FetchInitial());

  final PostRepo postRepo;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection(kUsersCollection);

  static GetPostCubit get(context) => BlocProvider.of(context);

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
    bool reset = false,
    required String userId,
  }) async {
    allPostsMap.isEmpty
        ? emit(GetPostsLoading())
        : emit(GetPostsPaginationLoading());

    var result = await postRepo.fetchPosts(userId: userId, reset: reset);
    result.fold((failure) {
      emit(GetPostsFailure(failure.message));
    }, (posts) async {
      if (posts.isEmpty) {
        emit(NoMorePosts());
      } else {
        await _getPostsUsers(posts);
        await organizeLikedPosts(posts);
        emit(GetPostsSuccess(posts));
      }
    });
  }

  Future<void> organizeLikedPosts(List<PostModel> posts) async {
    for (var post in posts) {
      if (post.isLiked) {
        likedPostsMap[post.postId] = post;
      }
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
}
