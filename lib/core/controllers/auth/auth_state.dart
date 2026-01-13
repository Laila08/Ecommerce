part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailed extends AuthState {
  final String error;
  AuthFailed(this.error);
}
final class AuthFormState extends AuthState {
  final AutovalidateMode autovalidateMode;
  final bool? isValidEmail;
  final bool? isValidPassword;
  final bool? isValidName;

  AuthFormState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.isValidEmail,
    this.isValidPassword,
    this.isValidName,
  });
}