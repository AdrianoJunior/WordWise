import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';

showSnackBar(
    {SignUpData? data,
    String? msg,
    required BuildContext context}) {
  final snackBar = SnackBar(
    content: Text(msg ?? 'Your account was successfully created.'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showErrorSnackBar({String? msg, required BuildContext context}) {
  final snackBar = SnackBar(
      content: Text(msg ??
          'There was an error creating your account. Please, try again.'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
