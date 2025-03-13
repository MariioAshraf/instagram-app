part of 'story_cubit.dart';

@immutable
sealed class StoryState {}

final class StoryInitial extends StoryState {}

/// about pick stories media
final class StoryMediaPickedSuccess extends StoryState {}

final class StoryMediaPickedFailure extends StoryState {
  final String errMsg;

  StoryMediaPickedFailure({required this.errMsg});
}

/// about pause and play stories videos
final class TriggerVideoPlayerSuccess extends StoryState {}

/// about upload stories
final class UploadStoriesLoading extends StoryState {}

final class UploadStoriesSuccess extends StoryState {}

final class UploadStoriesFailure extends StoryState {
  final String errMsg;

  UploadStoriesFailure({required this.errMsg});
}

/// about get my stories

final class GetMyStoriesSuccess extends StoryState {}

final class GetMyStoriesFailure extends StoryState {
  final String errMsg;

  GetMyStoriesFailure(this.errMsg);
}

final class GetMyStoriesLoading extends StoryState {}

/// about get friends stories
final class GetFriendsStoriesLoading extends StoryState {}

final class GetFriendsStoriesSuccess extends StoryState {}

final class GetFriendsStoriesFailure extends StoryState {
  final String errMsg;

  GetFriendsStoriesFailure(this.errMsg);
}

/// about display stories

final class LoadStorySuccess extends StoryState {
  final StoryModel story;

  LoadStorySuccess({required this.story});
}

final class LoadStoryFailure extends StoryState {
  final String errMsg;

  LoadStoryFailure({required this.errMsg});
}

final class LoadStoryLoading extends StoryState {}
final class StoriesOrganized extends StoryState {}

/// about timers initialization
final class StartTimer extends StoryState {}

final class VideoInitialized extends StoryState {}

/// about download stories
final class DownloadingStorySuccess extends StoryState {
  final StoryModel story;

  DownloadingStorySuccess({required this.story});
}

final class DownloadingStoryLoading extends StoryState {}
final class DownloadingStoryFailure extends StoryState {
  final String errMsg;

  DownloadingStoryFailure({required this.errMsg});
}
