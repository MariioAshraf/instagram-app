import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/login/data/domain/user_cases/login_use_case.dart';
import 'package:meta/meta.dart';
import '../../../models/user_model.dart';
import '../../data/models/login_input_body_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  final LoginUseCase loginUseCase;

  static LoginCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late UserModel userModel;

  Future<void> login() async {
    emit(LoginLoading());
    LoginInputBodyModel loginInputBodyModel = LoginInputBodyModel(
      email: emailController.text,
      password: passwordController.text,
    );
    var result = await loginUseCase.call(loginInputBodyModel);
    result.fold((l) => emit(LoginFailure(errMessage: l.message)), (userModel) {
      userModel = userModel;
      emit(LoginSuccess());
    });
  }
}
