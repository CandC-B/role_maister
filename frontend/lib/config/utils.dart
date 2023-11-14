import 'package:email_validator/email_validator.dart';
import 'package:role_maister/config/firebase_logic.dart';

bool isEmailValid(String email) {
  return EmailValidator.validate(email);
}

bool isPasswordValid(String password) {
  final passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  return passwordRegex.hasMatch(password);
}

Future<bool> isUsernameValid(String username) {
  return firebase.checkUsernameAlreadyExist(username);
}