import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/core/functions/hive_functions.dart';
import 'package:instagram_app/features/story/data/extensions/story_model_extension.dart';
import 'package:instagram_app/features/story/data/models/story_model.dart';

abstract class StoryRemoteDataSource {
  Future<List<StoryModel>> getMyStories({
    required String userId,
  });

  Future<List<StoryModel>> getFriendsStories({
    required List<String> localStoryIds,
    required String userId,
  });
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final storiesCollection =
      FirebaseFirestore.instance.collection(kUsersCollection);

  @override
  Future<List<StoryModel>> getFriendsStories({
    required List<String> localStoryIds,
    required String userId,
  }) async {
    // TODO: implement getMyStories
    throw UnimplementedError();
  }

  @override
  Future<List<StoryModel>> getMyStories({
    required String userId,
  }) async {
    final storiesSnapShot =
        await storiesCollection.doc(userId).collection(kStories).get();

    final Map<String, StoryModel> localStoriesMap = {
      for (var story in await HiveFunctions.getMyStories(userId))
        story.storyId: story
    };

    final List<Future<StoryModel?>> futures =
        storiesSnapShot.docs.map((storyDoc) async {
      final viewersSnapShot =
          await storyDoc.reference.collection('viewers').get();

      final StoryModel? localStory = localStoriesMap[storyDoc.id];

      if (localStory == null) {
        return StoryModel.fromJson(storyDoc.data()).copyWith(
          viewersIds: {},
          viewersModels: {},
        );
      }

      bool hasNewViewers = (localStory.viewersIds == null ||
          localStory.viewersIds!.keys.length != viewersSnapShot.size);

      if (hasNewViewers) {
        final updatedViewers =
            Map<String, String>.from(localStory.viewersIds ?? {});

        for (var viewerDoc in viewersSnapShot.docs) {
          final viewerId = viewerDoc.id;

          if (!updatedViewers.containsKey(viewerId)) {
            updatedViewers[viewerId] = viewerDoc.get('viewedAt');
          }
        }

        return localStory.copyWith(viewersIds: updatedViewers);
      }

      return null;
    }).toList();

    final stories = await Future.wait(futures);

    return stories.whereType<StoryModel>().toList();
  }
}
