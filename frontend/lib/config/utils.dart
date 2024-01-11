import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: source);
  if (image != null) {
    return await image.readAsBytes();
  }
  print("No image selected");
}
