import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthFormState()) {
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) validateEmail();
    });
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) validatePassword();
    });
    nameFocusNode.addListener(() {
      if (!nameFocusNode.hasFocus) validateName();
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();

  void validateEmail() {
    emit(
      AuthFormState(
        isValidEmail: EmailValidator.validate(emailController.text.trim()),
        autovalidateMode: state is AuthFormState
            ? (state as AuthFormState).autovalidateMode
            : AutovalidateMode.disabled,
        isValidPassword: state is AuthFormState
            ? (state as AuthFormState).isValidPassword
            : null,
        isValidName: state is AuthFormState
            ? (state as AuthFormState).isValidName
            : null,
      ),
    );
  }

  void validatePassword() {
    final value = passwordController.text.trim();
    emit(
      AuthFormState(
        autovalidateMode: state is AuthFormState
            ? (state as AuthFormState).autovalidateMode
            : AutovalidateMode.disabled,
        isValidEmail: state is AuthFormState
            ? (state as AuthFormState).isValidEmail
            : null,
        isValidPassword: value.isNotEmpty && value.length >= 6,
        isValidName: state is AuthFormState
            ? (state as AuthFormState).isValidName
            : null,
      ),
    );
  }

  void validateName() {
    final value = nameController.text.trim();
    emit(
      AuthFormState(
        autovalidateMode: state is AuthFormState
            ? (state as AuthFormState).autovalidateMode
            : AutovalidateMode.disabled,
        isValidEmail: state is AuthFormState
            ? (state as AuthFormState).isValidEmail
            : null,
        isValidPassword: state is AuthFormState
            ? (state as AuthFormState).isValidPassword
            : null,
        isValidName: value.isNotEmpty && value.length >= 2,
      ),
    );
  }

  void enableAutoValidate() {
    if (state is AuthFormState) {
      final current = state as AuthFormState;
      emit(
        AuthFormState(
          autovalidateMode: AutovalidateMode.always,
          isValidEmail: current.isValidEmail,
          isValidPassword: current.isValidPassword,
          isValidName: current.isValidName,
        ),
      );
    }
  }

  void disableAutoValidate() {
    if (state is AuthFormState) {
      final current = state as AuthFormState;
      emit(
        AuthFormState(
          autovalidateMode: AutovalidateMode.disabled,
          isValidEmail: current.isValidEmail,
          isValidPassword: current.isValidPassword,
          isValidName: current.isValidName,
        ),
      );
    }
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    emit(AuthFormState());
  }
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    nameFocusNode.dispose();
  }

  final authServices = AuthServicesImp();
  Future<void> login() async {
    emit(AuthLoading());
    try {
      final user = await authServices.loginWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed("Incorrect credentials"));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> signUp() async {
    emit(AuthLoading());
    try {
      final user = await authServices.signupWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed("Incorrect credentials"));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void authStatus() {
    final user = authServices.currentUser;
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authServices.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
