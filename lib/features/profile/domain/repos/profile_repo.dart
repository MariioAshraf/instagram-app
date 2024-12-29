import 'package:dartz/dartz.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';

import '../../../../core/errors/failure.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> updateUserNameAndBio(
      {String? name, String? bio, required UserModel userModel});
}
