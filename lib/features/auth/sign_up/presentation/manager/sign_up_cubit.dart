import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import '../../data/models/register_input_model.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpUseCase) : super(SignUpInitial());
  final SignUpUseCase signUpUseCase;
  final GlobalKey<FormState> formKey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  static SignUpCubit get(context) => BlocProvider.of(context);

  Future<void> signUp() async {
    emit(SignUpLoading());
    final RegisterInputModel registerInputModel = RegisterInputModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    final res = await signUpUseCase.call(registerInputModel);
    res.fold((e) => emit(SignUpFailure(errMessage: e.message)),
        (r) => emit(SignUpSuccess()));
  }
}
