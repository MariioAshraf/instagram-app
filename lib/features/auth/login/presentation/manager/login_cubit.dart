import 'package:bloc/bloc.dart';
import 'package:instagram_app/features/auth/login/data/repos/login_repo.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:meta/meta.dart';

import '../../data/models/login_input_body_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;
// late UserModel userModel;
  void login(LoginInputBodyModel loginInputBodyModel) async {
    emit(LoginLoading());
    var result = await loginRepo.login(loginInputBodyModel);
    result.fold((l) => emit(LoginFailure(errMessage: l.message)), (r) => null);
    emit(LoginSuccess());
  }
}
