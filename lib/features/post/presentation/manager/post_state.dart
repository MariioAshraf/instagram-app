part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostFilesPickedSuccess extends PostState {}

final class PostFilesPickedFailure extends PostState {
  final String errMessage;

  PostFilesPickedFailure(this.errMessage);
}

final class CreatePostSuccess extends PostState {}

final class CreatePostLoading extends PostState {}

final class CreatePostFailure extends PostState {
  final String errMessage;

  CreatePostFailure(this.errMessage);
}

final class CanUploadPost extends PostState {}

final class CanNotUploadPost extends PostState {}

final class CanComment extends PostState {}

final class CanNotComment extends PostState {}

final class GetPostsLoading extends PostState {}

final class GetPostsFailure extends PostState {
  final String errMessage;

  GetPostsFailure(this.errMessage);
}

final class GetPostsSuccess extends PostState {
  final List<PostModel> posts;

  GetPostsSuccess(this.posts);
}

final class ToggleLikeSuccess extends PostState {
  final String postId;

  ToggleLikeSuccess(this.postId);
}

final class ToggleLikeFailure extends PostState {
  final String errMessage;

  ToggleLikeFailure(this.errMessage);
}

final class FetchLikesCountSuccess extends PostState {
  final String postId;
  final int likesCount;

  FetchLikesCountSuccess(this.likesCount, this.postId);
}

final class FetchLikesCountFailure extends PostState {
  final String errMessage;

  FetchLikesCountFailure(this.errMessage);
}

final class FastToggleLike extends PostState {}

final class CreateCommentSuccess extends PostState {
  final String comment;

  CreateCommentSuccess(this.comment);
}

final class CreateCommentFailure extends PostState {
  final String errMessage;

  CreateCommentFailure(this.errMessage);
}

final class CreateCommentLoading extends PostState {}

final class FetchCommentsSuccess extends PostState {
  final List<CommentModel> comments;

  FetchCommentsSuccess(this.comments);
}

final class FetchCommentsFailure extends PostState {
  final String errMessage;

  FetchCommentsFailure(this.errMessage);
}

final class FetchCommentsLoading extends PostState {}
