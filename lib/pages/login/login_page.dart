import 'package:animated_login/animated_login.dart';
import 'package:dictionary/pages/home/home_page.dart';
import 'package:dictionary/pages/login/login_bloc.dart';
import 'package:dictionary/utils/api_response.dart';
import 'package:dictionary/utils/nav.dart';
import 'package:dictionary/utils/snackbar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return AnimatedLogin(
      logo: Image.asset('assets/logo/app_logo.png'),
      loginTexts: LoginTexts(
        welcomeBackDescription: '',
        notHaveAnAccount: 'Don\'t have an account?',
        welcomeDescription: '',
      ),
      validatePassword: false,
      signUpMode: SignUpModes.confirmPassword,
      loginMobileTheme: LoginViewTheme(
        backgroundColor: const Color(0xff203d7f),
        logoSize: const Size(200, 200),
        // hintTextStyle: const TextStyle(color: Colors.white),
        formFieldBackgroundColor: Colors.white,
      ),
      onLogin: (data) => _onClickLogin(data.email, data.password),
      onSignup: (data) => _onClickSignUp(data),
    );
  }

  Future<String?> _onClickLogin(String email, String password) async {
    ApiResponse response = await _bloc.login(email, password);
    if (response.ok) {
      showSnackBar(data: null, msg: response.msg, context: context);
      push(context, HomePage(), replace: true);
      return response.msg;
    } else {
      showErrorSnackBar(context: context, msg: response.msg);
      return response.msg;
    }
  }

  Future<String?> _onClickSignUp(SignUpData data) async {
    ApiResponse response = await _bloc.signUp(data.email, data.password);
    if (response.ok) {
      showSnackBar(data: data, msg: response.msg, context: context);
      return response.msg;
    } else {
      showErrorSnackBar(context: context, msg: response.msg);
      return response.msg;
    }
  }
}
