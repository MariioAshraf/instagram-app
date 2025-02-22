import 'package:hive/hive.dart';
import 'package:instagram_app/constants.dart';
import '../models/story_model.dart';

abstract class StoryLocalDataSource {
  List<StoryModel> getMyStories({required String userId});

  List<StoryModel> getFriendsStories();
}

class StoryLocalDataSourceImpl implements StoryLocalDataSource {
  @override
  List<StoryModel> getFriendsStories() {
    // TODO: implement getFriendsStories
    throw UnimplementedError();
  }

  @override
  List<StoryModel> getMyStories({required String userId}) {
    var box = Hive.box<StoryModel>(kStoriesCollection);
    return box.values.where((story) => story.userId == userId).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }
}
