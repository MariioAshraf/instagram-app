import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import '../../data/models/login_input_body_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> login(
      LoginInputBodyModel loginInputBodyModel);
}
