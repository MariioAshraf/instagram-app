import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/core/use_cases/use_case.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/post/data/models/post_model.dart';
import 'package:instagram_app/features/post/domain/repos/post_repo.dart';

class CreatePostUseCase extends UseCase<void, UserModel> {
  final PostRepo postRepo;

  CreatePostUseCase(this.postRepo);

  @override
  Future<Either<Failure, PostModel>> call(
      [UserModel? param, List<XFile>? media, String? postTitle]) async {
    if (media == null || media.isEmpty) {
      return await postRepo.createPost(
        userModel: param!,
        postTitle: postTitle,
      );
    }
    var result =
        await postRepo.uploadPostMedia(userId: param!.uId!, media: media);
    return result.fold((failure) => Left(failure), (fileUrls) async {
      return await postRepo.createPost(
        userModel: param,
        postMediaUrl: fileUrls,
        postTitle: postTitle,
      );
    });
  }
}
