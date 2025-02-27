import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repos/profile_repo.dart';

class ProfileUseCase extends UseCase<void, String> {
  final ProfileRepo profileRepo;

  ProfileUseCase(this.profileRepo);

  @override
  Future<Either<Failure, String>> call(
      [String? param, String? uId, String? type]) async {
    var result = await profileRepo.uploadUserProfileAndCoverImagesAndGetUrl(
        param!, uId!);
    return result.fold((failure) => Left(failure), (fileUrl) async {
      var result = await profileRepo.saveProfileAndCoverImagesUrl(
        imageUrl: fileUrl,
        uId: uId,
        type: type!,
      );
      print('rrrrrrrrrrrrrrrrrrrrrrrrr$fileUrl');
      return result.fold((failure) => Left(failure), (r) => Right(fileUrl));
    });
  }
}
