import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/story/data/repos/story_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/story_model.dart';

class StoryRepoImpl implements StoryRepo {
  @override
  Future<Either<Failure, void>> uploadStoryToFireBase({
    required UserModel userModel,
    required List<File> media,
    required List<String> captions,
    required List videoPlayerControllerList,
  }) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      for (int i = 0; i < media.length; i++) {
        final file = media[i];
        final isVideo = videoPlayerControllerList[i] != null;
        final MediaType mediaType = isVideo ? MediaType.video : MediaType.image;

        var result = await uploadStoryMedia(userModel.uId!, file);
        if (result.isLeft()) {
          return result;
        }

        final mediaUrl = result.fold((l) => null, (r) => r);

        final DocumentReference docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.uId)
            .collection('stories')
            .doc();

        final StoryModel storyModel = StoryModel(
          caption: captions[i],
          mediaType: mediaType,
          fileUrl: mediaUrl!,
          duration: isVideo
              ? videoPlayerControllerList[i]!.value.duration.inSeconds
              : 0,
          userId: userModel.uId!,
          createdAt: DateTime.now(),
          storyId: docRef.id,
          storyUserModel: userModel,
        );

        batch.set(docRef, storyModel.toJson());
      }
      await batch.commit();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadStoryMedia(
      String userId, File file) async {
    try {
      final supabase = Supabase.instance.client;
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';

      final String fullPath = 'story/$userId/$fileName';
      await supabase.storage.from('stories').upload(
            fullPath,
            file,
          );
      final String fileUrl =
          supabase.storage.from('stories').getPublicUrl(fullPath);

      return Right(fileUrl);
    } catch (e) {
      return Left(
          Failure('An error occurred while uploading media: ${e.toString()}'));
    }
  }

}
