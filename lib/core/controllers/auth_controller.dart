import 'package:ecommerceapp/core/services/auth_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthController with ChangeNotifier {
  final AuthServices auth;
  AuthController({required this.auth}) {
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

  final loginKey = GlobalKey<FormState>();
  final signupKey = GlobalKey<FormState>();
  final forgotPasswordKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMod = AutovalidateMode.disabled;
  AutovalidateMode get autovalidateMode => _autovalidateMod;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();

  bool? isValidEmail;
  bool? isValidPassword;
  bool? isValidName;

  void enableAutoValidate() {
    _autovalidateMod = AutovalidateMode.always;
    notifyListeners();
  }

  void disableAutoValidate() {
    _autovalidateMod = AutovalidateMode.disabled;
    notifyListeners();
  }

  void validateEmail() {
    final value = emailController.text.trim();
    isValidEmail = EmailValidator.validate(value);
    notifyListeners();
  }

  void validatePassword() {
    final value = passwordController.text.trim();
    final valid = value.isNotEmpty && value.length >= 6;
    if (isValidPassword != valid) {
      isValidPassword = valid;
      notifyListeners();
    }
  }

  void validateName() {
    final name = nameController.text.trim();
    bool validName = name.isNotEmpty && name.length >= 2;
    if (isValidName != validName) {
      isValidName = validName;
      notifyListeners();
    }
  }

  void clearAuth() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    isValidEmail = null;
    isValidPassword = null;
    isValidName = null;
    notifyListeners();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  Future<bool> signUpUser() async {
    if (!(signupKey.currentState!.validate())) {
      enableAutoValidate();
      return false;
    }
    try {
      await auth.signupUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<bool> signInUser() async {
    if (!(loginKey.currentState!.validate())) {
      enableAutoValidate();
      return false;
    }
    try {
      await auth.signinUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  void copyWith({String? email, String? password, String? name}) {
    emailController.text = email ?? emailController.text.trim();
    passwordController.text = password ?? passwordController.text.trim();
    nameController.text = name ?? nameController.text.trim();
    notifyListeners();
  }
}
