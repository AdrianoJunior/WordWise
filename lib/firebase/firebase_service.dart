import 'package:dictionary/utils/api_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse<User>> create(String login, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: login, password: password);

      final User? fUser = authResult.user;

      if(fUser != null) {

        return ApiResponse.ok(
            msg:
            'Your account was successfully created! Head back to the login screen to access the app.');
      }

      return ApiResponse.error(
          msg: "There was an error creating your account. Please, try again.");

    } catch (e) {
      if (e.toString().contains('[firebase_auth/email-already-in-use]')) {
        return ApiResponse.error(msg: 'The e-mail $login is already in use.');
      }
      return ApiResponse.error(
          msg: "There was an error creating your account. Please, try again.");
    }
  }

  Future<ApiResponse> signIn(String login, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: login, password: password);

      return ApiResponse.ok(msg: 'Login successfully');
    } catch (e) {
      return ApiResponse.error(
          msg:
              "There was an error logging into your account. Please, try again.");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
