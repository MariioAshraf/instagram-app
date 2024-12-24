import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/features/auth/sign_up/data/models/register_input_model.dart';
import 'package:instagram_app/features/auth/sign_up/domain/repos/sign_up_repo.dart';
import '../../../../../core/errors/failure.dart';

class SignUpRepoImpl implements SignUpRepo {
  @override
  Future<Either<Failure, String>> signUp(
      RegisterInputModel registerInputModel) async {
    try {
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: registerInputModel.email,
              password: registerInputModel.password);
      final uId = userCredentials.user!.uid;
      return Right(uId);
    } catch (e) {
      return Left(Failure( e.toString()));
    }
  }
}
