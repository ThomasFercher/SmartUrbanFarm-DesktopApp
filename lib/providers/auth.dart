import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  static String token;

  static Future<String> getAuthToken() async {
    if (token == null) {
      token = await authApp();
    }
    return token;
  }

  static Future<String> authApp() async {
    final response = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAeTF-VH5vxA0-ssHg4rMcjIodzBnnPvPw");
    Map<dynamic, dynamic> user = jsonDecode(response.body);
    return user['idToken'];
  }
}