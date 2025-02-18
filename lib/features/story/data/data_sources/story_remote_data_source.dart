import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/features/story/data/models/story_model.dart';

abstract class StoryRemoteDataSource {
  Future<List<StoryModel>> getMyStories({
    required Map<String, List<String>> viewersIds,
    required List<String> localStoriesIds,
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
    required Map<String, List<String>> viewersIds,
    required List<String> localStoriesIds,
    required String userId,
  }) async {
    final storiesSnapShot = await storiesCollection
        .doc(userId)
        .collection(kStories)
        .get();

    final List<Future<StoryModel?>> futures =
        storiesSnapShot.docs.map((storyDoc) async {
      final viewersSnapShot =
          await storyDoc.reference.collection('viewers').get();

      bool isNotStoredLocally = !localStoriesIds.contains(storyDoc.id);

      bool hasNewViewers = viewersIds[storyDoc.id] == null ||
          viewersIds[storyDoc.id]!.length != viewersSnapShot.size;

      if (isNotStoredLocally || hasNewViewers) {
        return StoryModel.fromJson(storyDoc.data());
      }
      return null;
    }).toList();

    final stories = await Future.wait(futures);

    return stories.whereType<StoryModel>().toList();
  }
}
