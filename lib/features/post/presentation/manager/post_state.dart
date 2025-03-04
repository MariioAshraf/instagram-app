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

final class GetPostsLoading extends PostState {}

final class GetPostsFailure extends PostState {
  final String errMessage;

  GetPostsFailure(this.errMessage);
}

final class GetPostsSuccess extends PostState {
  final List<PostModel> posts;

  GetPostsSuccess(this.posts);
}
