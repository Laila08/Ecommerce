import 'package:email_validator/email_validator.dart';

abstract class AppValidator {
  static Function passwordValidator = (String password) {
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  };

  static Function nameValidator = (String name) {
    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  };


  static Function emailValidator = (String email) {
    if (!EmailValidator.validate(email)) {
      return 'Not a valid email address. Should be your@email.com';
    }
    return null; // مهم جدًا
  };

}
