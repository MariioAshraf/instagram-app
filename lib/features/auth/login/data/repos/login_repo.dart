import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';
import '../models/login_input_body_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, void>> login(
      LoginInputBodyModel loginInputBodyModel);
}
