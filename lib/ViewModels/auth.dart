import 'package:flutter/material.dart';
import '../Services/auth.dart';
import '../Models/auth_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<String> registerUser(AuthModel user,
      {String? profileImagePath}) async {
    try {
      final response = await _authService.register(
        user,
        profileImagePath: profileImagePath, // مسار الصورة
      );

      if (response.containsKey('token')) {
        _isAuthenticated = true; // تم تسجيل المستخدم بنجاح
        return "تم تسجيل المستخدم بنجاح";
      } else {
        _isAuthenticated = false; // فشل العملية
        return "فشل في عملية التسجيل"; // الرسالة عند الفشل
      }
    } catch (e) {
      _isAuthenticated = false;
      debugPrint("Error during registration: $e");
      return "حدث خطأ أثناء التسجيل: $e"; // إرجاع رسالة خطأ واضحة
    }
  }
}
