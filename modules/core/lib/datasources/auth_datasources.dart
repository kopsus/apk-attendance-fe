import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasource {
  static Future<LoginModel> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
          Uri.parse('https://attendance-api.ios-services.com/user/login'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'EternalPlus@100'
          });
      return LoginModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw const ErrorModel(
          message: 'Login Gagal, Pastikan Email dan Password anda benar');
    }
  }

  static saveAccessToken(String accessToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', accessToken);
  }

  static saveExpiredAt(int expiredAt) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('expiredAt', expiredAt);
  }

  static saveName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('name', name);
  }

  static saveRole(String role) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('role', role);
  }

  static Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('accessToken') ?? '';
  }

  static Future<int> getExpiredAt() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('expiredAt') ?? 0;
  }

  static Future<String> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('name') ?? '';
  }

  static Future<String> getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('role') ?? '';
  }

  static clearSharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
