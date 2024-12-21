import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/features/auth/sign_up/data/models/register_input_model.dart';

abstract  class SignUpRepo {
  Future<Either<Failure, void>> signUp(RegisterInputModel registerInputModel);
}