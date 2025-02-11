part of 'story_cubit.dart';

@immutable
sealed class StoryState {}

final class StoryInitial extends StoryState {}

final class StoryMediaPickedSuccess extends StoryState {}

final class StoryMediaPickedFailure extends StoryState {
  final String errMsg;

  StoryMediaPickedFailure({required this.errMsg});
}
