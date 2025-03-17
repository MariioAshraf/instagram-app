part of 'get_post_cubit.dart';

@immutable
sealed class GetPostState {}

final class FetchInitial extends GetPostState {}

final class GetPostsLoading extends GetPostState {}

final class GetPostsPaginationLoading extends GetPostState {}

final class GetPostsFailure extends GetPostState {
  final String errMessage;

  GetPostsFailure(this.errMessage);
}

final class GetPostsSuccess extends GetPostState {
  final List<PostModel> posts;

  GetPostsSuccess(this.posts);
}

final class NoMorePosts extends GetPostState {}

final class ToggleLikeSuccess extends GetPostState {
  final String postId;

  ToggleLikeSuccess(this.postId);
}

final class ToggleLikeFailure extends GetPostState {
  final String errMessage;

  ToggleLikeFailure(this.errMessage);
}

final class FetchLikesCountSuccess extends GetPostState {
  final String postId;
  final int likesCount;

  FetchLikesCountSuccess(this.likesCount, this.postId);
}

final class FetchLikesCountFailure extends GetPostState {
  final String errMessage;

  FetchLikesCountFailure(this.errMessage);
}

final class FastToggleLike extends GetPostState {
  final bool like;
  final String postId;

  FastToggleLike(this.like, this.postId);
}
