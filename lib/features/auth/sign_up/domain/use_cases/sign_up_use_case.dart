import 'package:dartz/dartz.dart';
import 'package:instagram_app/features/auth/sign_up/domain/repos/sign_up_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
          final user = UserModel(name: param.name, uId: userId);
          final supabase = Supabase.instance.client;
          await supabase.from('users').insert(user.toJson());
          return const Right(null);
        } catch (e) {
          return Left(
              Failure(message: "Failed to save user data: ${e.toString()}"));
        }
      },
    );
  }
}
