import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_app/constants.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/core/use_cases/use_case.dart';
import 'package:instagram_app/features/auth/login/data/models/login_input_body_model.dart';
import 'package:instagram_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';

class LoginUseCase extends UseCase<UserModel, LoginInputBodyModel> {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  @override
  Future<Either<Failure, UserModel>> call([LoginInputBodyModel? param]) async {
    var result = await loginRepo.login(param!);
    return result.fold((failure) => Left(failure), (uId) async {
      final UserModel userModel = await getUserData(uId);
      return Right(userModel);
    });
  }

  Future<UserModel> getUserData(String uId) async {
    final usersCollection =
        FirebaseFirestore.instance.collection(kUsersCollection);
    final docSnapshot = await usersCollection.doc(uId).get();
    final userModel = UserModel.fromJson(docSnapshot.data());
    return userModel;
  }
}
