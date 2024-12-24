import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/errors/failure.dart';
import '../models/login_input_body_model.dart';
import '../../domain/repos/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  @override
  Future<Either<Failure, String>> login(
      LoginInputBodyModel loginInputBodyModel) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginInputBodyModel.email,
              password: loginInputBodyModel.password);
      final uId = userCredential.user!.uid;
      return Right(uId);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
