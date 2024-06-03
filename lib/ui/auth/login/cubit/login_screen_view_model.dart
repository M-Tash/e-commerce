import 'package:bloc/bloc.dart';
import 'package:e_commerce/domain/use_cases/login_use_case.dart';
import 'package:e_commerce/ui/auth/login/cubit/states.dart';
import 'package:e_commerce/ui/auth/register/cubit/states.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel extends Cubit<LoginStates> {
  LoginScreenViewModel({required this.loginUseCase})
      : super(LoginLoadingState());
  LoginUseCase loginUseCase;

  //todo:hold data - handle logic
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isObscure = true;

  void login() async {
    emit(LoginLoadingState());
    var either = await loginUseCase.invoke(
        emailController.text, passwordController.text);
    either.fold((l) => emit(LoginErrorState(errorMessage: l.errorMessage)),
        (response) => emit(LoginSuccessState(authResultEntity: response)));
  }
}
