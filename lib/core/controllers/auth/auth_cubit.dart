import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (isClosed) return;
    final trimmedEmail = emailController.text.trim();
    final isValid = EmailValidator.validate(trimmedEmail);
    final formState = state is AuthFormState ? state as AuthFormState : null;
    if (formState != null && formState.isValidEmail == isValid) return;
    if (isClosed) return;
    emit(
      AuthFormState(
        isValidEmail: EmailValidator.validate(emailController.text.trim()),
        autovalidateMode:
            formState?.autovalidateMode ?? AutovalidateMode.disabled,
        isValidPassword: formState?.isValidPassword,
        isValidName: formState?.isValidName,
      ),
    );
  }

  Future<void> sendResetPasswordEmail(String email) async {
    emit(AuthLoading());
    try {
      await authServices.sendResetPasswordEmail(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void validatePassword() {
    if (isClosed) return;

    final value = passwordController.text.trim();
    final isValid = value.isNotEmpty && value.length >= 6;
    final formState = state is AuthFormState ? state as AuthFormState : null;
    if (formState != null && formState.isValidEmail == isValid) return;
    if (isClosed) return;

    emit(
      AuthFormState(
        autovalidateMode:
            formState?.autovalidateMode ?? AutovalidateMode.disabled,
        isValidEmail: formState?.isValidEmail,
        isValidPassword: value.isNotEmpty && value.length >= 6,
        isValidName: formState?.isValidName,
      ),
    );
  }

  void validateName() {
    if (isClosed) return;

    final value = nameController.text.trim();
    final isValid = value.isNotEmpty && value.length >= 2;
    final formState = state is AuthFormState ? state as AuthFormState : null;
    if (formState != null && formState.isValidName == isValid) return;

    if (isClosed) return;
    emit(
      AuthFormState(
        autovalidateMode:
            formState?.autovalidateMode ?? AutovalidateMode.disabled,
        isValidEmail: formState?.isValidEmail,
        isValidPassword: formState?.isValidPassword,
        isValidName: value.isNotEmpty && value.length >= 2,
      ),
    );
  }

  String? emailValidator(String email) {
    if (email.trim().isEmpty) return "Email can't be empty";
    if (!EmailValidator.validate(email.trim())) {
      return "Not a valid email address";
    }
    return null;
  }

  String? passwordValidator(String password) {
    if (password.trim().length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? nameValidator(String name) {
    if (name.trim().length < 2) return "Name must be at least 2 characters";
    return null;
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

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    nameFocusNode.dispose();

    return super.close();
  }

  final authServices = AuthServicesImp();
  Future<void> login() async {
    emit(AuthLoading());
    try {
      await authServices.loginWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided for that user.";
      } else {
        errorMessage = e.message ?? "Login failed";
      }
      emit(AuthFailed(errorMessage));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> signUp() async {
    emit(AuthLoading());
    try {
      await authServices.signupWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already in use.";
      } else if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
      } else {
        errorMessage = e.message ?? "Sign up failed";
      }
      emit(AuthFailed(errorMessage));
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
