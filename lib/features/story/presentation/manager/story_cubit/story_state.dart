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
