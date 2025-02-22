import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/core/functions/hive_functions.dart';
import 'package:instagram_app/features/story/data/extensions/story_model_extension.dart';
import 'package:instagram_app/features/story/data/models/story_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

abstract class StoryRemoteDataSource {
  Future<List<StoryModel>> getMyStories({
    required String userId,
  });

  Future<List<StoryModel>> getFriendsStories({
    required List<String> localStoryIds,
    required String userId,
  });

  Future<StoryModel> downloadStoryFile(StoryModel storyModel);
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
    final storiesSnapShot = await storiesCollection
        .doc(userId)
        .collection(kStoriesCollection)
        .get();

    final Map<String, StoryModel> localStoriesMap = {
      for (var story in await HiveFunctions.getMyStories(userId))
        story.storyId: story
    };

    final List<Future<StoryModel?>> futures =
        storiesSnapShot.docs.map((storyDoc) async {
      final viewersSnapShot =
          await storyDoc.reference.collection('viewers').get();

      final StoryModel? localStory = localStoriesMap[storyDoc.id];
      final storyFile = File(localStory?.localFilePath ?? '');
      if (localStory == null ||
          localStory.hasNotLocalFilePath ||
          !storyFile.existsSync()) {
        final updatedStory = StoryModel.fromJson(storyDoc.data()).copyWith(
          viewersIds: {},
          viewersModels: {},
        );
        final newStory = await downloadStoryFile(updatedStory);
        return newStory;
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

  @override
  Future<StoryModel> downloadStoryFile(StoryModel storyModel) async {
    var box = Hive.box<StoryModel>(kStoriesCollection);
    final response = await http.get(Uri.parse(storyModel.fileUrl!));
    final Directory directory = await getApplicationDocumentsDirectory();
    String extension =
        storyModel.mediaType == MediaType.video ? '.mp4' : '.jpg';
    final newPath =
        path.join(directory.path, '${storyModel.storyId}$extension');
    final File localFile = File(newPath);
    await localFile.writeAsBytes(response.bodyBytes);
    storyModel = storyModel.copyWith(localFilePath: newPath);
    await box.put(storyModel.storyId, storyModel);
    debugPrint('File downloaded and saved: ${storyModel.toString()}');
    return storyModel;
  }
}
