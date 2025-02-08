import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';

import '../../../../core/errors/failure.dart';

abstract class StoryRepo {
  Future<Either<Failure, void>> uploadStoryToFireBase({
    required UserModel userModel,
    required List<File> media,
    required List<String> captions,
    required List videoPlayerControllerList,
  });

  Future<Either<Failure, String>> uploadStoryMedia(
    String userId,  File file
  );
}
