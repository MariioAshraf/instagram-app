import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/auth/user_model_extensions.dart';

import '../../../../constants.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<Failure, UserModel>> updateUserNameAndBio(
      {String? name, String? bio, required UserModel userModel}) async {
    try {
      final userDocRef = FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userModel.uId);
      final updatedUserModel = userModel.copyWith(name: name, bio: bio);
      if (name != null || bio != null) {
        await userDocRef.set(updatedUserModel.toJson());
      }
      return right(updatedUserModel);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? "An unknown Firebase error occurred"));
    } catch (e) {
      return left(Failure("An unexpected error occurred: ${e.toString()}"));
    }
  }
}
