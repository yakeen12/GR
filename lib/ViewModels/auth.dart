import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/utils/local_storage_service.dart';
import '../Services/auth.dart';
import '../Models/auth_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString token = ''.obs;

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

  Future<String> login(AuthModel user) async {
    isLoading(true);
    errorMessage('');
    try {
      // final authModel = AuthModel(email: email, password: password);
      final response = await _authService.login(user);
      token.value = response['token'];
      print('login viewModel model:');
      print("${user.email}, ${user.password}");
      print('Login Successful. Token: ${response['token']}');
      if (response.containsKey('token')) {
        _isAuthenticated = true; // تم تسجيل المستخدم بنجاح
        await LocalStorageService().saveToken(response['token']);
        return "Login Successful";
      } else {
        _isAuthenticated = false; // فشل العملية
        return "فشل في عملية التسجيل"; // الرسالة عند الفشل
      }
    } catch (e) {
      print('An error occurred: $e');

      // errorMessage('An error occurred: $e');
      return "حدث خطأ أثناء التسجيل: $e";
    } finally {
      isLoading(false);
    }
  }
}
