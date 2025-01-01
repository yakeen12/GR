
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
