import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:instagram_app/constants.dart';
import '../models/story_model.dart';

abstract class StoryLocalDataSource {
  List<StoryModel> getMyStories({required String userId});

  Map<String, List<StoryModel>> getFriendsStories({required String userId});
}

class StoryLocalDataSourceImpl implements StoryLocalDataSource {
  @override
  Map<String, List<StoryModel>> getFriendsStories({required String userId}) {
    final box = Hive.box<StoryModel>(kStoriesCollection);
    final Map<String, List<StoryModel>> storiesMap = {};
    for (var storyKey in box.keys) {
      StoryModel? story = box.get(storyKey);
      debugPrint('friends local story ${story?.toJson()}');
      if (story != null && story.userId != userId) {
        if (storiesMap.containsKey(story.userId)) {
          storiesMap[story.userId]!.add(story);
        } else {
          storiesMap[story.userId] = [story];
        }
      }
    }
    return storiesMap;
  }

  @override
  List<StoryModel> getMyStories({required String userId}) {
    var box = Hive.box<StoryModel>(kStoriesCollection);
    return box.values.where((story) => story.userId == userId).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }
}
