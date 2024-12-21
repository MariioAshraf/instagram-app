import 'package:bloc/bloc.dart';
import 'package:instagram_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:meta/meta.dart';

import '../../data/models/register_input_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpUseCase) : super(SignUpInitial());
  SignUpUseCase signUpUseCase;

  Future<void> signUp(RegisterInputModel registerInputModel) async {
    emit(SignUpLoading());
    final res = await signUpUseCase.call(registerInputModel);
    res.fold((e) => emit(SignUpFailure(errMessage: e.message)),
        (r) => emit(SignUpSuccess()));
  }
}
