import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_app/features/auth/sign_up/domain/repos/sign_up_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../../../models/user_model.dart';
import '../../data/models/register_input_model.dart';

class SignUpUseCase extends UseCase<void, RegisterInputModel> {
  final SignUpRepo signUpRepo;

  SignUpUseCase(this.signUpRepo);

  @override
  Future<Either<Failure, void>> call([RegisterInputModel? param]) async {
    final result = await signUpRepo.signUp(param!);

    return result.fold(
      (failure) => Left(failure),
      (userId) async {
        try {
          await saveUserData(param, userId);
          return const Right(null);
        } catch (e) {
          return Left(
              Failure(message: "Failed to save user data: ${e.toString()}"));
        }
      },
    );
  }

  Future<void> saveUserData(RegisterInputModel param, String userId) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final userModel =
        UserModel(name: param.name, uId: userId, profileImageUrl: '');
    await usersCollection.doc(userId).set(userModel.toJson());
  }
}
