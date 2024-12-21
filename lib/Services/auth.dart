// import 'dart:convert';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:music_app/Models/auth_model.dart';

// class AuthService {
//   final String baseUrl =
//       'https://music-app-server-50cl.onrender.com/api/auth'; // رابط الخادم

//   Future<Map<String, dynamic>> register(
//     AuthModel userData, {
//     String? profileImagePath,
//   }) async {
//     var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));

//     // إضافة بيانات المستخدم
//     // request.fields.addAll(userData.toJson());

//     printError(info: "request");
//     // إضافة الصورة إذا وُجدت
//     // if (profileImagePath != null) {
//     //   request.files.add(await http.MultipartFile.fromPath(
//     //     'profilePicture',
//     //     profileImagePath,
//     //   ));
//     // }
//     print("profileImagePath: ${profileImagePath}");
//     print("${request.fields.keys}: ${request.fields.values}");

//     // إرسال الطلب
//     // var response = await request.send();

//     final response = await http.post(
//       Uri.parse('$baseUrl/register'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'username': userData.username,
//         'email': userData.email,
//         'password': userData.password,
//         'profilePicture': profileImagePath
//       }),
//     );
//     print(response.headers);

//     if (response.statusCode == 201) {
//       // var responseData = await http.Response.fromStream(response);
//       // return json.decode(responseData.body);
//       return response.headers;
//     } else {
//       throw Exception('Failed to register user${response.statusCode}');
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/Models/auth_model.dart';

class AuthService {
  final String baseUrl =
      'https://music-app-server-50cl.onrender.com/api/auth'; // رابط الخادم

  Future<Map<String, dynamic>> register(
    AuthModel userData, {
    String? profileImagePath,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));

    // إضافة بيانات المستخدم إلى الطلب
    request.fields.addAll(userData.toJson());

    // إضافة الصورة إذا وُجدت
    if (profileImagePath != null) {
      // إضافة الملف إلى الطلب
      var file =
          await http.MultipartFile.fromPath('profilePicture', profileImagePath);
      request.files.add(file);
    }

    // طباعة البيانات للتحقق
    print("profileImagePath: $profileImagePath");
    print("${request.fields.keys}: ${request.fields.values}");

    // إرسال الطلب
    var response = await request.send();

    // انتظار استجابة الخادم
    if (response.statusCode == 201) {
      var responseData = await http.Response.fromStream(response);
      print("register Sucsess ");
      return json.decode(responseData.body);
    } else {
      throw Exception(
          'Failed to register user with status code: ${response.statusCode}');
    }
  }
}
