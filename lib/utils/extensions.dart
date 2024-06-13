import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

typedef void OnActionClick();

extension ShowSnackMessage on SnackBar {
  static SnackBar fromMessage(
      String message, String actionLabel, OnActionClick onAtcnClick) {
    return SnackBar(
      content: Text(message),
      action: SnackBarAction(label: actionLabel, onPressed: onAtcnClick),
    );
  }
}

String emailValidatorText(String email) {
  if (email.isEmpty) {
    return 'Email cannot be blank';
  } else if (!EmailValidator.validate(email)) {
    return 'Enter a valid email';
  } else {
    return '';
  }
}

String passwordValidatorText(String password) {
  if (password.isEmpty) {
    return 'Password cannot be blank';
  } else if (password.length < 8) {
    return 'Password must be 8 character in length';
  } else {
    return '';
  }
}
