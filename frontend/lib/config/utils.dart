import 'package:email_validator/email_validator.dart';

bool isEmailValid(String email) {
  return EmailValidator.validate(email);
}

bool isPasswordValid(String password) {
  final passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  return passwordRegex.hasMatch(password);
}

bool isUsernameValid(String username) {
  return username.length > 3 ? true : false;
}