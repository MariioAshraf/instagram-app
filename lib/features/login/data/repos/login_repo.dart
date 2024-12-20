import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/login_failure.dart';
import 'package:instagram_app/features/login/data/models/login_input_body_model.dart';

abstract class LoginRepo {
  Either<LoginFailure, Future<void>> login(
      LoginInputBodyModel loginInputBodyModel);
}
