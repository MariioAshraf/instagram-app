import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/errors/failure.dart';
import '../models/login_input_body_model.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  @override
  Future<Either<Failure, void>> login(
      LoginInputBodyModel loginInputBodyModel) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithPassword(
          email: loginInputBodyModel.email,
          password: loginInputBodyModel.password);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
