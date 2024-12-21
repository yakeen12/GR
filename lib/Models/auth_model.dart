import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// class AuthService {
//   final String baseUrl =
//       'https://music-app-server-50cl.onrender.com/api/auth'; // ضع رابط السيرفر هنا

//   Future<Map<String, dynamic>> signIn(
//     String username,
//     String email,
//     String password,
//     String? profileImagePath,
//   ) async {
//     //   final response = await http.post(
//     //     Uri.parse('$baseUrl/register'),
//     //     headers: {'Content-Type': 'application/json'},
//     //     body: json.encode({
//     //       'username': username,
//     //       'email': email,
//     //       'password': password,
//     //     }),
//     //   );

//     //   printError(info: "response register");
//     //   print(email + "" + response.body);

//     //   if (response.statusCode == 201) {
//     //     print("response register");
//     //     print(response.body);

//     //     return json.decode(response.body);
//     //   } else {
//     //     throw Exception('Failed to sign in');
//     //   }
//     // }

//     // إعداد طلب multipart لإرسال البيانات
//     final uri = Uri.parse('$baseUrl/register');
//     final request = http.MultipartRequest('POST', uri);

//     // الحقول النصية
//     request.fields['username'] = username;
//     request.fields['email'] = email;
//     request.fields['password'] = password;

//     // إضافة الصورة إذا تم اختيارها
//     if (profileImagePath != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'profilePicture', // اسم الحقل على السيرفر
//           profileImagePath,
//         ),
//       );
//     }

//     // إرسال الطلب والحصول على الاستجابة
//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     print("Response status: ${response.statusCode}");
//     print("Response body: ${response.body}");

//     if (response.statusCode == 201) {
//       // إذا تمت العملية بنجاح
//       return json.decode(response.body);
//     } else {
//       // في حالة حدوث خطأ
//       throw Exception('Failed to sign in: ${response.body}');
//     }
//   }
// }

class AuthModel {
  final String username;
  final String email;
  final String password;
  final String? profilePicture; // الصورة قد تكون اختيارية

  AuthModel({
    required this.username,
    required this.email,
    required this.password,
    this.profilePicture,
  });

  // لتحويل البيانات إلى JSON لإرسالها إلى الخادم
  Map<String, String> toJson() {
    return {'username': username, 'email': email, 'password': password};
  }

  // لإنشاء كائن مستخدم من استجابة الخادم
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      profilePicture: json['profilePicture'], // رابط الصورة
    );
  }
}
