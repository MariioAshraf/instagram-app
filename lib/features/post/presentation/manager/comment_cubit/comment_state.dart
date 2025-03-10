part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}
final class FetchCommentsSuccess extends CommentState {
  final List<CommentModel> comments;

  FetchCommentsSuccess(this.comments);
}

final class FetchCommentsFailure extends CommentState {
  final String errMessage;

  FetchCommentsFailure(this.errMessage);
}

final class FetchCommentsLoading extends CommentState {}
final class CanComment extends CommentState {}

final class CanNotComment extends CommentState {}


final class CreateCommentSuccess extends CommentState {
  final String comment;

  CreateCommentSuccess(this.comment);
}

final class CreateCommentFailure extends CommentState {
  final String errMessage;

  CreateCommentFailure(this.errMessage);
}

final class CreateCommentLoading extends CommentState {}
