import 'package:get/get.dart';
import 'package:music_app/services/user_service.dart';
import 'package:music_app/models/user_model.dart';

class UserViewModel extends GetxController {
  var isLoading = false.obs; // لتحديد ما إذا كانت البيانات في التحميل
  var user =
      Rx<User?>(null); // لتخزين بيانات المستخدم، نوع البيانات هو Rx<User>

  var errorMessage = ''.obs; // لتخزين أي رسالة خطأ إذا حدثت

  // Method to fetch user profile from the server
  Future<void> fetchUserProfile(String token) async {
    isLoading(true); // بدء التحميل
    try {
      var response = await UserService()
          .getUserProfile(token); // الحصول على البروفايل باستخدام الخدمة
      if (response != null) {
        user.value = User(
            id: response.id,
            username: response.username,
            email: response.email,
            likedSongs: response.likedSongs,
            likedPosts: response.likedPosts,
            comments: response.comments,
            profilePicture: response.profilePicture,
            secretGifts: response.secretGifts);
      } else {
        errorMessage.value = 'Failed to load profile.';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false); // إيقاف التحميل
    }
  }
}
