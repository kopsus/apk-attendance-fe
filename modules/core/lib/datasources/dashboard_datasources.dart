import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardDatasource {
  static Future<DashboardStatusModel> getDashboardStatus() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse(
              'https://attendance-api.ios-services.com/user/getAttendanceStatus'),
          headers: {
            'Authorization': 'Bearer ${pref.getString('accessToken')}'
          });
      print(response.body);
      return DashboardStatusModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      throw const ErrorModel(message: 'Server Error');
    }
  }

  static Future<DashboardHistoryModel> getDashboardHistory() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse(
              'https://attendance-api.ios-services.com/user/getHistoryByUserId'),
          headers: {
            'Authorization': 'Bearer ${pref.getString('accessToken')}'
          });
      return DashboardHistoryModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw const ErrorModel(message: 'Server Error');
    }
  }

  static Future<bool> postAttendance(XFile image) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://attendance-api.ios-services.com/user/attendance'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('photo', File(image.path).path),
      );
      request.headers['Authorization'] =
          'Bearer ${pref.getString('accessToken')}';

      await request.send();

      return true;
    } catch (e) {
      throw const ErrorModel(message: 'Server Error');
    }
  }
}
