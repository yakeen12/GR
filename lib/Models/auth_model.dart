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

// class AuthModel {
//   final String username;
//   final String email;
//   final String password;
//   final String? profilePicture; // الصورة قد تكون اختيارية

//   AuthModel({
//     required this.username,
//     required this.email,
//     required this.password,
//     this.profilePicture,
//   });

//   // لتحويل البيانات إلى JSON لإرسالها إلى الخادم
//   Map<String, String> toJson() {
//     return {'username': username, 'email': email, 'password': password};
//   }

//   // لإنشاء كائن مستخدم من استجابة الخادم
//   factory AuthModel.fromJson(Map<String, dynamic> json) {
//     return AuthModel(
//       username: json['username'],
//       email: json['email'],
//       password: json['password'],
//       profilePicture: json['profilePicture'], // رابط الصورة
//     );
//   }
// }

// class AuthModel {
//   final String? username; // قد يكون موجودًا في الساين إن فقط
//   final String email;
//   final String password;
//   final String? profilePicture; // اختيارية

//   AuthModel({
//     this.username,
//     required this.email,
//     required this.password,
//     this.profilePicture,
//   });

//   // تحويل إلى JSON
//   Map<String, String> toJson({bool isSignUp = false}) {
//     final data = {
//       'email': email,
//       'password': password,
//     };

//     // عند التسجيل فقط
//     if (isSignUp) {
//       if (username != null) data['username'] = username!;
//       if (profilePicture != null) data['profilePicture'] = profilePicture!;
//     }
//     return data;
//   }
// }

class AuthModel {
  final String? username; // اسم المستخدم (اختياري في حالة تسجيل الدخول)
  final String email; // البريد الإلكتروني
  final String password; // كلمة المرور
  final String? profilePicture; // رابط الصورة (اختياري)

  AuthModel({
    this.username,
    required this.email,
    required this.password,
    this.profilePicture,
  });

  // لتحويل البيانات إلى JSON لإرسالها إلى السيرفر
  Map<String, String> toJson() {
    // print(email);
    // print(password);
    return {
      if (username != null) 'username': username!, // يُرسل فقط إذا كان موجودًا
      'email': email,
      'password': password,
      if (profilePicture != null) 'profilePicture': profilePicture!,
    };
  }

  // لإنشاء كائن مستخدم من استجابة السيرفر
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'],
      email: json['email'],
      password: json['password'], // يُفترض أنك لن تعرض كلمة المرور
      profilePicture: json['profilePicture'], // رابط الصورة إذا كان موجودًا
    );
  }
}
