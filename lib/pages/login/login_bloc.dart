import 'package:dictionary/firebase/firebase_service.dart';
import 'package:dictionary/utils/api_response.dart';

class LoginBloc {
  Future<ApiResponse> login(String login, String password) async {
    ApiResponse response = await FirebaseService().signIn(login, password);

    return response;
  }

  Future<ApiResponse> signUp(String login, String password) async {
    ApiResponse response = await FirebaseService().create(login, password);

    return response;
  }
}
