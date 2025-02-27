import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../constants.dart';
import '../../features/auth/models/user_model.dart';
import '../../features/story/data/models/story_model.dart';

class HiveFunctions {
  static Future<StoryModel?> getStory(String storyId) async {
    var box = Hive.box<StoryModel>(kStoriesCollection);
    StoryModel? story = box.get(storyId);
    return story;
  }

  static Future<List<StoryModel>> getMyStories(String userId) async {
    var box = Hive.box<StoryModel>(kStoriesCollection);
    return box.values.where((story) => story.userId == userId).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  static Future<void> saveStory(
    String? localPath,
    StoryModel story,
    UserModel userModel,
  ) async {
    var box = Hive.box<StoryModel>(kStoriesCollection);
    StoryModel localStory = StoryModel(
      storyUserModel: userModel,
      caption: story.caption,
      mediaType: story.mediaType,
      duration: story.duration,
      userId: story.userId,
      createdAt: story.createdAt,
      localFilePath: localPath,
      storyId: story.storyId,
      viewersIds: <String, String>{},
      viewersModels: <String, UserModel>{},
    );
    await box.put(story.storyId, localStory);
    debugPrint('story saved to hive${localStory.toJson()}');
  }

  static saveStories(List<StoryModel> stories) {
    var box = Hive.box<StoryModel>(kStoriesCollection);
    Map<String, StoryModel> storiesMap = {
      for (var story in stories) story.storyId: story
    };
    box.putAll(storiesMap);
  }

  static Future<UserModel> saveUserModel(UserModel userModel) async {
    var box = Hive.box<UserModel>(kUserModelBox);
    await box.put(kUserModelBox, userModel);
    return userModel;
  }

  static Future<UserModel?> getUserModel() async {
    var box = Hive.box<UserModel>(kUserModelBox);
    return box.get(kUserModelBox);
  }
}
