import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/Models/auth_model.dart';
import 'package:music_app/Views/auth/login.dart';
import 'package:music_app/utils/local_storage_service.dart';

class AuthService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/auth'; // رابط الخادم

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

  Future<void> logout() async {
    try {
      // جلب التوكن المحفوظ
      final token = LocalStorageService().getToken();
      if (token == null) {
        throw Exception("No token found");
      }

      // إرسال طلب تسجيل الخروج إلى السيرفر
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Logout successful");

        // حذف التوكن من التخزين المحلي
        await LocalStorageService().clearToken();

        
        Get.offAll(const LoginPage()); // تأكد أن "/login" معرف كروت في GetX
      } else {
        throw Exception('Failed to log out: ${response.body}');
      }
    } catch (e) {
      print("Logout error: $e");
    }
  }
}
