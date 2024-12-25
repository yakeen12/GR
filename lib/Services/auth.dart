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

  

Future<Map<String, dynamic>> login(AuthModel authModel) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': authModel.email,
        'password': authModel.password,
      }),
    );

    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، قم بتحليل الرد
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print("Login successful: $responseData");

      // إعادة البيانات مع التوكين
      return responseData;
    } else {
      // إذا كانت الاستجابة غير ناجحة، قم بإرجاع رسالة الخطأ
      print("Error: ${response.statusCode}, ${response.body}");
      return {'error': 'Login failed'};
    }
  } catch (e) {
    print("Exception: $e");
    return {'error': 'Exception occurred'};
  }
}

  // Future<Map<String, dynamic>> logIn(String email, String password) async {
  //   final uri = Uri.parse('$baseUrl/login');
  //   final response = await http.post(
  //     uri,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'email': email, 'password': password}),
  //   );

  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to log in: ${response.body}');
  //   }
  // }
  // // تسجيل الدخول
  // Future<Map<String, dynamic>> login(AuthModel authModel) async {
  //   var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/login'));

  //   // إضافة بيانات المستخدم إلى الطلب
  //   request.fields.addAll(authModel.toJson());

  //   // طباعة البيانات للتحقق
  //   print("${request.fields.keys}: ${request.fields.values}");

  //   // أرسل الطلب
  //   var streamedResponse = await request.send();
  //   var response = await http.Response.fromStream(streamedResponse);

  //   // تحقق من الاستجابة
  //   if (response.statusCode == 201) {
  //     print("Login successful: ${response.body}");

  //     return json.decode(response.body);
  //   } else {
  //     print("Error: ${response.statusCode}, ${response.body}");
  //     throw Exception(
  //         'Failed to login user with status code: ${response.statusCode}');
  //   }

  //   // إرسال الطلب
  //   // var response = await request.send();

  //   // انتظار استجابة الخادم
  //   // if (response.statusCode == 201) {
  //   //   var responseData = await http.Response.fromStream(response);
  //   //   print("login Sucsess ");
  //   //   return json.decode(responseData.body);
  //   // } else {
  //   //   throw Exception(
  //   //       'Failed to login user with status code: ${response.statusCode}');
  //   // }

  //   // final response = await http.post(
  //   //   url,
  //   //   headers: {'Content-Type': 'application/json'},
  //   //   body: json.encode(authModel.toJson()),
  //   // );

  //   // if (response.statusCode == 200) {
  //   //   return json.decode(response.body);
  //   // } else {
  //   //   throw Exception('Login failed: ${response.body}');
  //   // }
  // }
}
