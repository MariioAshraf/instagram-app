import 'package:dartz/dartz.dart';
import 'package:instagram_app/features/auth/sign_up/data/models/register_input_model.dart';
import 'package:instagram_app/features/auth/sign_up/domain/repos/sign_up_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/errors/failure.dart';


class SignUpRepoImpl implements SignUpRepo {
  @override
  Future<Either<Failure, String>> signUp(
      RegisterInputModel registerInputModel) async {
    try {
      final supabase = Supabase.instance.client;
      final AuthResponse res = await supabase.auth.signUp(
        email: registerInputModel.email,
        password: registerInputModel.password,
      );
      return Right(res.user!.id);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
