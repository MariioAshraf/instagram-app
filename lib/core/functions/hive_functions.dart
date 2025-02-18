import 'package:hive/hive.dart';
import '../../constants.dart';
import '../../features/auth/models/user_model.dart';
import '../../features/story/data/models/story_model.dart';

class HiveFunctions {
  static Future<StoryModel?> getStory(String storyId) async {
    var box = Hive.box<StoryModel>(kStories);
    StoryModel? story = box.get(storyId);
    return story;
  }

  static Future<List<StoryModel>> getMyStories(String userId) async {
    var box = Hive.box<StoryModel>(kStories);
    return box.values.where((story) => story.userId == userId).toList();
  }

  static Future<void> saveStory(
    String? localPath,
    StoryModel story,
    UserModel userModel,
  ) async {
    var box = Hive.box<StoryModel>(kStories);
    StoryModel localStory = StoryModel(
      storyUserModel: userModel,
      caption: story.caption,
      mediaType: story.mediaType,
      duration: story.duration,
      userId: story.userId,
      createdAt: story.createdAt,
      localFilePath: localPath,
      storyId: story.storyId,
      fileUrl: story.fileUrl,
      // save fileUrl cause if the user opened his acc from another device

      viewersIds: <String, String>{},
      viewersModels: <String, UserModel>{},
    );
    await box.put(story.storyId, localStory);
    print('story saved to hive${localStory.toJson()}');
  }

  static saveStories(List<StoryModel> stories) {
    var box = Hive.box<StoryModel>(kStories);
    Map<String, StoryModel> storiesMap = {
      for (var story in stories) story.storyId: story
    };
    box.putAll(storiesMap);
  }
}
