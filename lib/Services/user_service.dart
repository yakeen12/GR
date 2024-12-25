import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/Models/user_model.dart';

class UserService {
  final String baseUrl =
      'https://music-app-server-50cl.onrender.com/api/users'; // الرابط الخاص بالخادم

  // طلب بيانات المستخدم
  Future<User?> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getprofile'),
      headers: {
        'Authorization': token, // إرسال التوكن في الهيدر
      },
    );
    print("response.body");

    print(response.body);
    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، قم بتحليل البيانات
      return User.fromJson(jsonDecode(response.body));
    } else {
      // إذا كانت الاستجابة فشلت، إرجاع null
      return null;
    }
  }
}
