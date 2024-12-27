import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // Singleton للتأكد من وجود نسخة واحدة فقط من SharedPreferences
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // حفظ التوكين
  Future<void> saveToken(String token) async {
    await _preferences?.setString('authToken', token);
  }

  // استرجاع التوكين
  String? getToken() {
    return _preferences?.getString('authToken');
  }

  // حذف التوكين
  Future<void> clearToken() async {
    await _preferences?.remove('authToken');
  }
  
}
