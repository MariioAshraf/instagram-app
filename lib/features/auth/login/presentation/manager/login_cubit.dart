import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants.dart';
import '../../../models/user_model.dart';
import '../../data/models/login_input_body_model.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  final LoginUseCase loginUseCase;

  static LoginCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late UserModel userModel;
  final usersCollection =
      FirebaseFirestore.instance.collection(kUsersCollection);

  Future<void> login() async {
    emit(LoginLoading());
    LoginInputBodyModel loginInputBodyModel = LoginInputBodyModel(
      email: emailController.text,
      password: passwordController.text,
    );
    var result = await loginUseCase.call(loginInputBodyModel);
    result.fold((failure) => emit(LoginFailure(errMessage: failure.message)),
        (userModel) {
      this.userModel = userModel;
      emit(LoginSuccess());
    });
  }

  Future<void> getUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(GetUserLoading());
      final uId = FirebaseAuth.instance.currentUser!.uid;
      final docSnapShot = await usersCollection.doc(uId).get();
      userModel = UserModel.fromJson(docSnapShot);
      emit(GetUserSuccess());
    }
  }

  disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }
}
