import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/constants.dart';
import '../../../../auth/models/user_model.dart';
import '../../../data/models/comment_model.dart';
import '../../../domain/repos/post_repo.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.postRepo) : super(CommentInitial());

  static CommentCubit get(context) => BlocProvider.of(context);
  final PostRepo postRepo;
  final _usersCollection =
      FirebaseFirestore.instance.collection(kUsersCollection);

  Future<void> fetchComments(String postId, Map postsUsers) async {
    emit(FetchCommentsLoading());
    final result = await postRepo.fetchComments(postId);
    result.fold((failure) {
      emit(FetchCommentsFailure(failure.message));
    }, (comments) async {
      await getCommentsUsers(comments, postsUsers);
      emit(FetchCommentsSuccess(comments));
    });
  }

  void checkCommentStatus() {
    if (commentController.text.trim().isEmpty) {
      emit(CanNotComment());
    } else {
      emit(CanComment());
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

  Future<void> getCommentsUsers(
      List<CommentModel> comments, Map postsUsers) async {
    for (var comment in comments) {
      if (postsUsers.containsKey(comment.userId)) continue;
      final userDoc = await _usersCollection.doc(comment.userId).get();
      final userModel =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      postsUsers[comment.userId] = userModel;
    }
  }
}
