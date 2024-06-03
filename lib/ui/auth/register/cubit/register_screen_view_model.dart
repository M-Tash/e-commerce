import 'package:bloc/bloc.dart';
import 'package:e_commerce/domain/use_cases/register_use_case.dart';
import 'package:e_commerce/ui/auth/register/cubit/states.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends Cubit<RegisterStates> {
  RegisterScreenViewModel({required this.registerUseCase})
      : super(RegisterLoadingState());

  //todo:hold data - handle logic
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  bool isObscure = true;

  RegisterUseCase registerUseCase;

  void register() async {
    emit(RegisterLoadingState());
    var either = await registerUseCase.invoke(
        nameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        phoneController.text);
    either.fold((l) => emit(RegisterErrorState(errorMessage: l.errorMessage)),
        (response) => emit(RegisterSuccessState(authResultEntity: response)));
  }
}
