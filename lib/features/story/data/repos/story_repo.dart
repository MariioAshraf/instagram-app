import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import '../../../../core/errors/failure.dart';
import '../models/story_model.dart';

abstract class StoryRepo {
  Future<Either<Failure, void>> uploadStory({
    required UserModel userModel,
    required List<File> media,
    required List<String> captions,
    required List videoPlayerControllerList,
  });

  Future<Either<Failure, String>> uploadStoryMedia(String userId, File file);

  Future<Either<Failure, List<StoryModel>>> getMyStories({required String userId});

  Future<Either<Failure, void>> getFriendsStories();
}
